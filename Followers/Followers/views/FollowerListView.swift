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
    @Bindable var addViewModel = addFavoriteViewModel

    @State private var presentedUser: String?
    @State private var updating: CGFloat = .zero
    @State private var hasError = false

    let columns: [GridItem] = [.init(), .init(), .init()]

    init(username: String) {
        _username = State(wrappedValue: username)
    }

    var body: some View {
        ZStack {
            if viewModel.followers.isEmpty,
               !viewModel.isLoading,
               viewModel.error == nil {
                EmptyStateView(message: "This user doesn't have any followers. Go follow them.")
            } else if viewModel.error != nil {
                EmptyView()
            } else {
                gridView
                    .searchable(text: $viewModel.searchText, prompt: "Search for a username")
            }
        }
        .customAlert(addViewModel.error?.title ?? "Error", isPresented: $addViewModel.showingAlert, actionText: addViewModel.error?.buttonTitle ?? "Ok", action: {}, message: {
            BodyLabel(title: addViewModel.error?.errorDescription ?? "Something went wrong")
        })
        .overlay {
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .navigationTitle(username)
        .task {
            await viewModel.getFollowers(username: username)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await addViewModel.addFavorite(username: username)
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .tint(.green)
            }
        }
        .customAlert("Success!", isPresented: $addViewModel.showingSuccess, actionText: "Horay!", action: {}, message: {
            BodyLabel(title: "You have successfully favorited this user")
        })
        .customAlert(viewModel.error?.title ?? "Error", isPresented: $viewModel.showingAlert, actionText: viewModel.error?.buttonTitle ?? "Ok", action: {}, message: {
            BodyLabel(title: viewModel.error?.errorDescription ?? "Something went wrong")
        })
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
