//
//  View+Followers.swift
//  Followers
//
//  Created by Eduard Ptushko on 27.02.2024.
//

import SwiftUI

extension View {
    func customAlert(
        _ titleKey: String,
        isPresented: Binding<Bool>,
        actionText: String,
        action: @escaping () -> Void,
        @ViewBuilder message: @escaping () -> some View
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            CustomAlertView(
                titleKey,
                isPresented: isPresented,
                actionTextKey: actionText,
                action: action,
                message: message
            )
            .presentationBackground(.clear)
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
            transaction.animation = .linear(duration: 0.1)
        }
    }
}
