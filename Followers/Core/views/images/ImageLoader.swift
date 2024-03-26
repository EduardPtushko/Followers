//
//  ImageLoader.swift
//  Followers
//
//  Created by Eduard Ptushko on 17.03.2024.
//

import SwiftUI

actor ImageLoader {
    private var session = URLSession.shared
    private var loaderStatuses: [URL: LoaderStatus] = [:]

    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }

    func fetch(_ url: URL) async -> UIImage {
        let errorImage = UIImage(resource: .avatarPlaceholder)

        if let status = loaderStatuses[url] {
            switch status {
            case .fetched(let image):
                return image
            case .inProgress(let task):
                return (try? await task.value) ?? errorImage
            }
        }

        let task: Task<UIImage, Error> = Task {
            let image: UIImage

            do {
                let (imageData, _) = try await session.data(from: url)
                let imageFromNetwork = UIImage(data: imageData)
                image = imageFromNetwork ?? errorImage
            } catch {
                image = errorImage
            }

            return image
        }

        loaderStatuses[url] = .inProgress(task)

        do {
            let image = try await task.value
            loaderStatuses[url] = .fetched(image)
            return image
        } catch {
            loaderStatuses[url] = .fetched(errorImage)
            return errorImage
        }
    }

    func setSession(_ session: URLSession) async {
        self.session = session
    }
}

struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue = ImageLoader()
}

extension EnvironmentValues {
    var imageLoader: ImageLoader {
        get { self[ImageLoaderKey.self] }
        set { self[ImageLoaderKey.self] = newValue }
    }
}

struct RemoteImage: View {
    let source: String
    @State private var image: UIImage = .init(resource: .avatarPlaceholder)

    @Environment(\.imageLoader) private var imageLoader

    var body: some View {
        Group {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .task {
            await loadImage(at: source)
        }
    }

    func loadImage(at source: String) async {
        if let url = URL(string: source) {
            image = await imageLoader.fetch(url)
        }
    }
}

#Preview {
    RemoteImage(source: "https://avatars.githubusercontent.com/u/217?v=4")
}
