//
//  LoadingView.swift
//  Followers
//
//  Created by Eduard Ptushko on 22.02.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .controlSize(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(.init(white: 0, alpha: 0.03))
            )
            .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
