//
//  UserInfoView.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import SafariServices
import SwiftUI

struct UserInfoView: View {
    @State private var viewModel = UserInfoViewModel()
    let username: String
    @Environment(\.dismiss)
    var dismiss
    @State private var isAlertPresented = false
    @State private var errorMessage = ""

    @State private var isPresentWebView = false

    var action: () -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if let user = viewModel.user {
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
            if let user = viewModel.user {
                SFSafariWebView(url: URL(string: user.htmlUrl)!)
            }
        })
        .task {
            await viewModel.getUser(username: username)
        }
    }
}

#Preview {
    UserInfoView(username: "goz", action: {})
}
