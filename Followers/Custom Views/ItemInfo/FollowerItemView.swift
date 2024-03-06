//
//  FollowerItemView.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.02.2024.
//

import SwiftUI

struct FollowerItemView: View {
    let user: User
    var action: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ItemInfoView(itemInfoType: .followers(user.followers))
                Spacer()
                ItemInfoView(itemInfoType: .following(user.following))
            }
            .frame(minHeight: 50)
            .padding(.horizontal)
            .padding(.top)

            FollowersButton(backgroundColor: .green, title: "Get Followers") {
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
    FollowerItemView(user: User.sampleUser, action: {})
}
