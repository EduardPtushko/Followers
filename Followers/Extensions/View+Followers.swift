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

//    func customAlert<M: View>(_ titleKey: String, isPresented: Binding<Bool>, actionTextKey: String, action: @escaping (() -> Void), @ViewBuilder message: @escaping () -> M) ->
//    some View {
//        modifier(CustomAlertViewModifier(titleKey: titleKey, isPresented: isPresented, actionTextKey: actionTextKey, action: action, message: message))
//    }
}

// struct CustomAlertViewModifier<M: View>: ViewModifier {
//    let titleKey: String
//    @Binding var isPresented: Bool
//    let actionTextKey: String
//
//    var action: (() -> ())?
//    var message: (() -> M)?
//
//    func body(content: Content) -> some View {
//        content
//            .fullScreenCover(isPresented: $isPresented, content: {
//                CustomAlertView(
//                    titleKey,
//                    isPresented: $isPresented,
//                    actionTextKey: actionTextKey
//                ) {
//                    action?()
//                } message: {
//                    message?()
//                }
//                .presentationBackground(.clear)
//            })
//            .transaction { transaction in
//                transaction.disablesAnimations = true
//                transaction.animation = .linear(duration: 0.1)
//            }
//    }
//
//
// }
