//
//  EmptyStateView.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String
    var body: some View {
        GeometryReader { _ in
            VStack {
                TitleLabel(textAlignment: .center, fontSize: 28, text: message)
                    .foregroundStyle(Color.secondary)
                    .lineLimit(3)
                    .frame(height: 200)
                    .padding(.horizontal, 40)
                Spacer()
                Image("empty-state-logo")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .scaleEffect(1.4)
                    .offset(x: 110)
                    .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    EmptyStateView(message: "This user doesn't have any followers. Go follow them.")
}
