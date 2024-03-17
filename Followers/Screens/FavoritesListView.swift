//
//  FavoritesListView.swift
//  Followers
//
//  Created by Eduard Ptushko on 13.01.2024.
//

import SwiftUI

struct FavoritesListView: View {
    @State private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.favorites.isEmpty {
                EmptyStateView(message: "No Favorites?\nAdd one on the follower screen")
                    .navigationTitle("Favorites")
            } else {
                List {
                    ForEach(viewModel.favorites) { favorite in
                        NavigationLink(value: favorite) {
                            HStack {
                                AsyncImage(url: URL(string: favorite.avatarUrl)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Images.placeholder.resizable()
                                }
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                                TitleLabel(textAlignment: .leading, fontSize: 28, text: favorite.login)
                                    .padding(.leading)
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.deleteFavorite(offsets: indexSet)
                    })
                }
                .listStyle(.plain)
                .navigationTitle("Favorites")
                .navigationDestination(for: Follower.self) { favorite in
                    FollowerListView(username: favorite.login)
                }
                .onAppear {
                    viewModel.getFavorites()
                }
            }
        }
        .customAlert(viewModel.followersError?.title ?? "", isPresented: $viewModel.showingAlert, actionText: "Ok", action: {}, message: {
            Text(viewModel.followersError?.description ?? "")
        })
        .onAppear {
            viewModel.getFavorites()
        }
    }
}

#Preview {
    FavoritesListView()
}
