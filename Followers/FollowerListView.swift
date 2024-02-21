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

    let columns: [GridItem] = [.init(), .init(), .init()]

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.followers) { follower in
                        VStack {
                            AvatarImageView(urlSting: follower.avatarUrl)
                            .padding(8)

                            Text(follower.login)
                                .font(.title3)
                                .frame(height: 20)
                        }
                        .padding(.top, 12)
                    }
                }
                .padding()
            }

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
