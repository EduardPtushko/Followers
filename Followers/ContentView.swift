//
//  ContentView.swift
//  Followers
//
//  Created by Eduard Ptushko on 13.01.2024.
//
//
import SwiftUI

struct ContentView: View {
    @SceneStorage("tab_selection") var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                        .tint(.green)
                }
                .tag(0)

            FavoritesListView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(1)
        }
        .tint(.green)
    }
}

#Preview {
    ContentView()
}
