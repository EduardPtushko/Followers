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
                    GFTitleLabel(textAlignment: .leading, fontSize: 34, text: user.login)
                    GFSecondaryTitleLabel(title: user.name ?? "", fontSize: 18)
                    HStack {
                        Image(systemName: SFSymbols.location)
                        GFSecondaryTitleLabel(title: user.location ?? "No Location", fontSize: 18)


                    }
                }
                .padding(.leading, 12)
                Spacer()
            }

            GFBodyLabel(title: user.bio ?? "No bio available")
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .padding(.top)
        }
        .padding()
    }
}

#Preview {


    return UserInfoHeaderView(user: User.sampleUser)
}
