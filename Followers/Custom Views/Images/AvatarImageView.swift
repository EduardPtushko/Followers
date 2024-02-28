//
//  AvatarImageView.swift
//  Followers
//
//  Created by Eduard Ptushko on 21.02.2024.
//

import SwiftUI

struct AvatarImageView: View {
    let cache = NetworkManager.shared.cache
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
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            self.image = Image(uiImage: image)
            return
        }
        guard let url = URL(string: urlString) else { return }

        guard let (data, response) = try? await URLSession.shared.data(from: url) as? (Data, HTTPURLResponse), response.statusCode == 200 else {
            return
        }

        guard let uiImage = UIImage(data: data) else { return }

        cache.setObject(uiImage, forKey: cacheKey)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    AvatarImageView(urlSting: "https://avatars.githubusercontent.com/u/217?v=4")
}
