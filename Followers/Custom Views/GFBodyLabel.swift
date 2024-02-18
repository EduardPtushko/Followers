//
//  GFBodyLabel.swift
//  Followers
//
//  Created by Eduard Ptushko on 16.02.2024.
//

import SwiftUI

struct GFBodyLabel: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.secondary)
            .minimumScaleFactor(0.75)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    GFBodyLabel(title: "Empty Username")
}

struct BodyLabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundStyle(.secondary)
            .minimumScaleFactor(0.75)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func gfBodyLabel() -> some View {
        modifier(BodyLabelModifier())
    }
}
