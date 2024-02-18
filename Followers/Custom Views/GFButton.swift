//
//  GFButton.swift
//  Followers
//
//  Created by Eduard Ptushko on 13.01.2024.
//

import SwiftUI

struct GFButton: View {
    let backgroundColor: Color
    let title: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    GFButton(backgroundColor: .blue, title: "Click me") {}
        .frame(height: 50)
        .padding(.horizontal,50)
}

