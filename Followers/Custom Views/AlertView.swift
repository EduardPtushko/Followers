//
//  AlertView.swift
//  Followers
//
//  Created by Eduard Ptushko on 16.02.2024.
//

import SwiftUI

struct AlertView: View {
    var alertTitle: String = "Something went wrong"
    var message: String = "Unable to complete request"
    var buttonTitle: String = "OK"
    let padding: CGFloat = 20
    let action: () -> Void

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.75)
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 2)
                .foregroundStyle(Color.white)
                .background(Color(.systemBackground))
                .frame(width: 280, height: 220)
                .overlay (
                    VStack {
                        Text(alertTitle)
                            .gfTitleLabel(textAlignment: .center, fontSize: 20)
                            .frame(height: 28)
                            .padding(.horizontal, padding)
                            .padding(.top, padding)
                        Spacer()
                        Text(message)
                            .gfBodyLabel()
                            .padding(.horizontal, padding)
                            .padding(.top, 8)
                        Spacer()
                        GFButton(backgroundColor: Color.pink, title: "Ok") {
                            action()
                        }
                        .frame(height: 44)
                        .padding(.horizontal, padding)
                        .padding(.bottom, padding)
                    }

                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    AlertView(alertTitle: "Empty Username", message: "Please enter a username. We need to know who to look for.", buttonTitle: "Ok", action: {})
}
