//
//  UserInfoHeaderView.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import SwiftUI

struct UserInfoHeaderView: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AvatarImageView(urlSting: user.avatarUrl)
                    .frame(width: 90, height: 90)
                VStack(alignment: .leading, spacing: 4) {
                    TitleLabel(textAlignment: .leading, fontSize: 34, text: user.login)
                    SecondaryTitleLabel(title: user.name ?? "", fontSize: 18)
                    HStack {
                        SFSymbols.location
                        SecondaryTitleLabel(title: user.location ?? "No Location", fontSize: 18)
                    }
                }
                .padding(.leading, 12)
                Spacer()
            }

            BodyLabel(title: user.bio ?? "No bio available")
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .padding(.top)
        }
        .padding()
    }
}

#Preview {
    UserInfoHeaderView(user: User.sampleUser)
}
