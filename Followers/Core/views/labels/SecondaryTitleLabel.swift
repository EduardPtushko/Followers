//
//  SecondaryTitleLabel.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import SwiftUI

struct SecondaryTitleLabel: View {
    let title: String
    let fontSize: CGFloat

    var body: some View {
        Text(title)
            .font(.system(size: fontSize, weight: .medium))
            .foregroundStyle(Color.secondary)
            .truncationMode(.tail)
            .minimumScaleFactor(0.90)
    }
}

#Preview {
    SecondaryTitleLabel(title: "Singapore", fontSize: 18)
}
