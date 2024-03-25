//
//  AvatarImageView.swift
//  Followers
//
//  Created by Eduard Ptushko on 21.02.2024.
//

import SwiftUI

struct AvatarImageView: View {
    let cache = ImageCache.shared
    @State private var image: Image = .init(.avatarPlaceholder)
    let urlSting: String

    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .task {
                await getAvatarImage(from: urlSting)
            }
    }

    func getAvatarImage(from urlString: String) async {
        if let image = cache.get(key: urlSting) {
            self.image = Image(uiImage: image)
            return
        }
        guard let url = URL(string: urlString) else { return }

        guard let (data, response) = try? await URLSession.shared.data(from: url) as? (Data, HTTPURLResponse), response.statusCode == 200 else {
            return
        }

        guard let uiImage = UIImage(data: data) else { return }

        cache.set(uiImage, key: urlString)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    AvatarImageView(urlSting: "https://avatars.githubusercontent.com/u/217?v=4")
}
