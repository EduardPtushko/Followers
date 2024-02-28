//
//  ItemInfoView.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.02.2024.
//

import SwiftUI

struct ItemInfoView: View {
    let itemInfoType: ItemInfoType

    var body: some View {
        VStack(spacing: 4.0) {
            HStack(spacing: 12) {
                itemInfoType.image
                    .frame(width: 20, height: 20)

                TitleLabel(textAlignment: .leading, fontSize: 14, text: itemInfoType.text)
            }

            TitleLabel(textAlignment: .leading, fontSize: 14, text: itemInfoType.count)
        }
    }
}

#Preview {
    ItemInfoView(itemInfoType: .repos(User.sampleUser.publicRepos))
}
