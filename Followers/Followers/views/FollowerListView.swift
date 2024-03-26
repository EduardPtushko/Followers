//
//  FollowerListView.swift
//  Followers
//
//  Created by Eduard Ptushko on 17.01.2024.
//

import SwiftUI

struct FollowerListView: View {
    @State var username: String
    @State private var viewModel = FollowersViewModel(followersService: FollowersService(requestManager: RequestManager(apiManager: APIManager())))

    @State private var presentedUser: String?
    @State private var updating: CGFloat = .zero
    @State private var hasError = false

    let columns: [GridItem] = [.init(), .init(), .init()]

    init(username: String) {
        _username = State(wrappedValue: username)
    }

    var body: some View {
        ZStack {
            if viewModel.followers.isEmpty, !viewModel.isLoading {
                EmptyStateView(message: "This user doesn't have any followers. Go follow them.")
            } else {
                gridView
                    .searchable(text: $viewModel.searchText, prompt: "Search for a username")
            }
        }
        .overlay {
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .navigationTitle(username)
        .task {
            await viewModel.getFollowers(username: username)
        }
//        .onChange(of: viewModel.error) { _, newValue in
//            hasError = newValue != nil
//        }
        .onChange(of: viewModel.state) { _, newValue in
            hasError = newValue == .error
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await viewModel.addFavorite(username: username)
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .tint(.green)
            }
        }
        .customAlert("Success!", isPresented: $viewModel.showingSuccess, actionText: "Horray!", action: {}, message: {
            BodyLabel(title: "You have successfully favorited this user")
        })
//        .customAlert(viewModel.error?.title ??  "Error", isPresented: $hasError, actionText: "Ok", action: {}, message: {
//            BodyLabel(title: viewModel.error?.description ?? "")
//        })
        .sheet(item: $presentedUser, content: { username in
            UserInfoView(username: username) {
                Task {
                    viewModel.reset()
                    await viewModel.getFollowers(username: username)
                    self.username = username
                    presentedUser = nil
                }
            }
        })
    }
}

extension FollowerListView {
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.filteredFollowers) { follower in
                    VStack {
//                        AvatarImageView(urlSting: follower.avatarUrl)
                        RemoteImage(source: follower.avatarUrl)
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

                        if follower == viewModel.followers.last {
                            Task {
                                await viewModel.getMoreFollowers(username: username)
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
    NavigationStack {
        FollowerListView(username: "SAllen0400")
    }
}

extension String: Identifiable { public var id: String { self } }
