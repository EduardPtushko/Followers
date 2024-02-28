//
//  UserInfoView.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import SafariServices
import SwiftUI

struct UserInfoView: View {
    let username: String
    @Environment(\.dismiss)
    var dismiss
    @State private var isAlertPresented = false
    @State private var errorMessage = ""
    @State private var user: User?

    @State private var isPresentWebView = false

    var action: () -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if let user {
                        UserInfoHeaderView(user: user)

                        RepoItemView(user: user) {
                            isPresentWebView = true
                        }
                        .padding(.horizontal)

                        FollowerItemView(user: user) {
                            action()
                        }
                        .padding(.horizontal)

                        Text("Github since \(user.createdAt.convertToMonthYearFormat())")
                    }
                    Spacer()
                }

                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                        .tint(.green)
                    }
                }
                if isAlertPresented {}
            }
        }
        .fullScreenCover(isPresented: $isPresentWebView, content: {
            if let user {
                SFSafariWebView(url: URL(string: user.htmlUrl)!)
            }
        })
        .task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                self.user = user

            } catch {
                isAlertPresented = true
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    UserInfoView(username: "goz", action: {})
}
