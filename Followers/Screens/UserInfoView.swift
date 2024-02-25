//
//  UserInfoView.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import SwiftUI

struct UserInfoView: View {
    let username: String
    @Environment(\.dismiss)
    var dismiss
    @State private var isAlertPresented = false
    @State private var errorMessage = ""
    @State private var user: User?


    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if let user {
                        UserInfoHeaderView(user: user)

                        RepoItemView(user: user)
                            .padding(.horizontal)

                        FollowerItemView(user: user)
                            .padding(.horizontal)

                        Text("Github since \(user.createdAt.convertToDisplayFormat())")
                    }
                    Spacer()
                }

                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                              dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                             dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
            }
                if isAlertPresented {

                }
            }
        }
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
    UserInfoView(username: "goz")
}
