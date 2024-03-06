//
//  CustomAlertView.swift
//  Followers
//
//  Created by Eduard Ptushko on 16.02.2024.
//

import SwiftUI

struct CustomAlertView<M: View>: View {
    @Binding var isPresented: Bool
    @State private var titleKey: String
    @State private var actionTextKey: String

    private var action: (() -> Void)?
    private var message: (() -> M)?

    @State private var isAnimating = false
    private let animationDuration = 0.5

    init(_ titleKey: String, isPresented: Binding<Bool>, actionTextKey: String, action: @escaping () -> Void, @ViewBuilder message: @escaping () -> M) {
        _titleKey = State(wrappedValue: titleKey)
        _isPresented = isPresented
        _actionTextKey = State(wrappedValue: actionTextKey)

        self.action = action
        self.message = message
    }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(isPresented ? 0.75 : 0)
                .zIndex(1)

            if isAnimating {
                VStack {
                    Text(titleKey)
                        .gfTitleLabel(textAlignment: .center, fontSize: 20)
                        .frame(height: 28)
                        .padding()
                    Group {
                        if let message {
                            message()
                                .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)

                    actionButton
                }
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
                .frame(width: 280, height: 220)
                .transition(.opacity)
                .zIndex(.greatestFiniteMagnitude)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            show()
        }
    }

    private var actionButton: some View {
        FollowersButton(backgroundColor: Color.pink, title: actionTextKey, systemName: "checkmark") {
            dismiss()
            if let action {
                action()
            }
        }
        .frame(height: 44)
        .padding()
    }

    private func dismiss() {
        if #available(iOS 17.0, *) {
            withAnimation(.easeInOut(duration: animationDuration)) {
                isAnimating = false
            } completion: {
                isPresented = false
            }
        } else {
            withAnimation(.easeInOut(duration: animationDuration)) {
                isAnimating = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                isPresented = false
            }
        }
    }
}

extension CustomAlertView {
    func show() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            isAnimating = true
        }
    }
}

// MARK: - Preview

struct CustomAlertPreview: View {
    @State private var isPresented = false
    @State private var test = "Some Value"

    var body: some View {
        VStack {
            Button("Show Alert") {
                isPresented = true
            }
            .customAlert(
                "Alert Title",
                isPresented: $isPresented,
                actionText: "Yes, Done"
            ) {} message: {
                Text("Showing alert for… And adding a long text for preview.")
            }
        }
    }
}

#Preview {
    //    @State var isPresented = true
    //
    //    return  CustomAlertView("Empty Username", $isPresented, actionTextKey: "Ok") {
    //
    //    } message: {
    //        BodyLabel(title: "Something went wrong!")
    //    }

    CustomAlertPreview()
}
