//
//  FollowerListView.swift
//  Followers
//
//  Created by Eduard Ptushko on 17.01.2024.
//

import SwiftUI

struct FollowerListView: View {
    let username: String
    @State private var viewModel = FollowersViewModel()
    private var showingAlert: Bool {
        viewModel.error != nil
    }

    var body: some View {
        ZStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)

            if showingAlert {
                AlertView(alertTitle: "Empty Username", message: "Please enter a username. We need to know who to look for.", buttonTitle: "Ok") {
                    viewModel.error = nil

                }

            }
        }
            .task {
                await viewModel.getFollowers(username: username)
            }
    }
}

#Preview {
    FollowerListView(username: "apple")
}
