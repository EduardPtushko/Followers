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

    @State private var presentedUser: String?


    @State private var updating: CGFloat = .zero
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismissSearch) var dismissSearch
    let columns: [GridItem] = [.init(), .init(), .init()]

    var body: some View {
            ZStack {
                if viewModel.isEmptyView {
                    GFEmptyStateView(message: "This user doesn't have any followers. Go follow them.")
                } else {
                    gridView
                        .searchable(text: $viewModel.searchText, prompt: "Search for a username")
                        .onChange(of: viewModel.searchText, { oldValue, newValue in
                           
                        })
                }

                if viewModel.isLoading {
                    LoadingView()
                        .background(Color(.systemBackground)
                        .opacity(viewModel.isLoading ? 0 : 0.8))
                        .animation(.easeInOut(duration: 0.5), value: viewModel.isLoading)

                }

                if showingAlert {
//                    AlertView(alertTitle: "Empty Username", message: "Please enter a username. We need to know who to look for.", buttonTitle: "Ok") {
//                        viewModel.error = nil
//                    }
                }
            }
           
            .sheet(item: $presentedUser, content: { username in
                UserInfoView(username: username)
            })
            .onSubmit(of: .search) {
                print("hi searcg")
            }
            .task {
                await viewModel.getFollowers(username: username)
        }

    }
}

extension FollowerListView {
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.filteredFollowers) { follower in
                    VStack {
                        AvatarImageView(urlSting: follower.avatarUrl)
                            .padding(8)

                        Text(follower.login)
                            .font(.title3)
                            .frame(height: 20)
                    }
                    .onTapGesture {
                        presentedUser = follower.login
                    }
                    .padding(.top, 12)

                    .onAppear {
                        guard viewModel.hasMoreFollowers else { return }
                        if  follower == viewModel.followers.last {
                            Task {
                                print("hi")
                                await viewModel.getFollowers(username: username)
                            }
                        }
                    }

                }

            }
            .padding()
        }
    }
}

#Preview {
//    FollowerListView(username: "EduardPtushko")
    NavigationStack {
        FollowerListView(username: "SAllen0400")
    }
}
extension String: Identifiable { public var id: String { self } }
