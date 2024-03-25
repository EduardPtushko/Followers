//
//  FollowersButton.swift
//  Followers
//
//  Created by Eduard Ptushko on 13.01.2024.
//

import SwiftUI

struct FollowersButton: View {
    let backgroundColor: Color
    let title: String
    var systemName: String? = nil
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if let systemName {
                    Image(systemName: systemName)
                }
                Text(title)
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    FollowersButton(backgroundColor: .blue, title: "Click me", systemName: "checkmark", action: {})
        .frame(height: 50)
        .padding(.horizontal, 50)
}
