//
//  FollowerListView.swift
//  Followers
//
//  Created by Eduard Ptushko on 17.01.2024.
//

import SwiftUI

struct FollowerListView: View {
    @State var username: String
    @State private var followersViewModel = FollowersViewModel(followersService: FollowersService(requestManager: RequestManager(apiManager: APIManager())))
    @State private var addViewModel = AddFavoriteViewModel(addFavoriteService: AddingFavoriteService(requestManager: RequestManager(apiManager: APIManager())))

    @State private var presentedUser: String?
    @State private var updating: CGFloat = .zero

    let columns: [GridItem] = [.init(), .init(), .init()]

    init(username: String) {
        _username = State(wrappedValue: username)
    }

    var body: some View {
        ZStack {
            if followersViewModel.followers.isEmpty,
               !followersViewModel.isLoading,
               followersViewModel.error == nil {
                EmptyStateView(message: "This user doesn't have any followers. Go follow them.")
            } else if followersViewModel.error != nil {
                EmptyView()
            } else {
                gridView
                    .searchable(text: $followersViewModel.searchText, prompt: "Search for a username")
            }
        }
        .customAlert(addViewModel.error?.title ?? "Error", isPresented: $addViewModel.showingAlert, actionText: addViewModel.error?.buttonTitle ?? "Ok", action: {}, message: {
            BodyLabel(title: addViewModel.error?.errorDescription ?? "Something went wrong")
        })
        .overlay {
            if followersViewModel.isLoading {
                LoadingView()
            }
        }
        .navigationTitle(username)
        .task {
            await followersViewModel.getFollowers(username: username)
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
        .customAlert(
            followersViewModel.error?.title ?? "Error",
            isPresented: $followersViewModel.showingAlert,
            actionText: followersViewModel.error?.buttonTitle ?? "Ok",
            action: {},
            message: {
                BodyLabel(title: followersViewModel.error?.errorDescription ?? "Something went wrong")
            }
        )
        .sheet(item: $presentedUser, content: { username in
            UserInfoView(username: username) {
                Task {
                    followersViewModel.reset()
                    await followersViewModel.getFollowers(username: username)
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
                ForEach(followersViewModel.filteredFollowers) { follower in
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
                        guard followersViewModel.hasMoreFollowers else { return }

                        if follower == followersViewModel.followers.last {
                            Task {
                                await followersViewModel.getMoreFollowers(username: username)
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
