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

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text(username)
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                              dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("")
                            .bold()
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
//                    AlertView(alertTitle: "Something went wrong", message: errorMessage) {
//
//                    }
                }
            }
        }
        .task {
            do {
              let user = try await NetworkManager.shared.getUserInfo(for: username)
                print(user)
            } catch {
                isAlertPresented = true
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    UserInfoView(username: "apple")
}
