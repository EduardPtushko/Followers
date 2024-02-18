//
//  ContentView.swift
//  Followers
//
//  Created by Eduard Ptushko on 13.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
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
