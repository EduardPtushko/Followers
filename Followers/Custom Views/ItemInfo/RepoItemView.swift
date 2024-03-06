//
//  RepoItemView.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.02.2024.
//

import SwiftUI

enum ItemInfoType {
    case repos(Int)
    case gists(Int)
    case followers(Int)
    case following(Int)

    var count: String {
        switch self {
        case let .repos(int):
            return String(int)
        case let .gists(int):
            return String(int)
        case let .followers(int):
            return String(int)
        case let .following(int):
            return String(int)
        }
    }

    var text: String {
        switch self {
        case .repos: return "Public Repos"
        case .gists: return "Public Gists"
        case .followers: return "Followers"
        case .following: return "Following"
        }
    }

    var image: Image {
        switch self {
        case .repos:
            return SFSymbols.repos
        case .gists:
            return SFSymbols.gists
        case .followers:
            return SFSymbols.followers
        case .following:
            return SFSymbols.following
        }
    }
}

struct RepoItemView: View {
    let user: User
    var action: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ItemInfoView(itemInfoType: .repos(user.publicRepos))
                Spacer()
                ItemInfoView(itemInfoType: .gists(user.publicGists))
            }
            .frame(height: 50)
            .padding(.horizontal)
            .padding(.top)

            FollowersButton(backgroundColor: .purple, title: "Github Profile") {
                action()
            }
            .frame(height: 44)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(.secondarySystemBackground))
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    RepoItemView(user: User.sampleUser, action: {})
}
