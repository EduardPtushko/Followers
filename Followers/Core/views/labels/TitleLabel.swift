//
//  TitleLabel.swift
//  Followers
//
//  Created by Eduard Ptushko on 16.02.2024.
//

import SwiftUI

struct TitleLabel: View {
    let textAlignment: TextAlignment
    let fontSize: CGFloat
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .bold))
            .truncationMode(.tail)
            .minimumScaleFactor(0.90)
            .multilineTextAlignment(textAlignment)
    }
}

#Preview {
    TitleLabel(textAlignment: .center, fontSize: 20, text: "Empty Username")
}

struct TitleLabelModifier: ViewModifier {
    let textAlignment: TextAlignment
    let fontSize: CGFloat

    func body(content: Content) -> some View {
        content
            .truncationMode(.tail)
            .font(.system(size: fontSize, weight: .bold))
            .minimumScaleFactor(0.90)
            .multilineTextAlignment(textAlignment)
    }
}

extension View {
    func gfTitleLabel(textAlignment: TextAlignment = .center, fontSize: CGFloat) -> some View {
        modifier(TitleLabelModifier(textAlignment: textAlignment, fontSize: fontSize))
    }
}
