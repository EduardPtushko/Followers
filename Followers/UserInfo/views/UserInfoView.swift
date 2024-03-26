//
//  UserInfoView.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import SafariServices
import SwiftUI

struct UserInfoView: View {
    @Environment(\.dismiss)
    var dismiss
    @State private var viewModel = UserInfoViewModel(userInfoFetcher: GetUserInfoService(requestManager: RequestManager(apiManager: APIManager())))
    let username: String

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
                            if URL(string: user.htmlUrl) != nil {
                                isPresentWebView = true
                            } else {
                                isAlertPresented = true
                            }
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
            }
        }
        .customAlert("Invalid URL", isPresented: $isAlertPresented, actionText: "Ok", action: {}, message: {
            Text("The url attached to this user is invalid")
        })
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
