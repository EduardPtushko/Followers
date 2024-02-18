//
//  FollowersApp.swift
//  Followers
//
//  Created by Eduard Ptushko on 13.01.2024.
//

import SwiftUI

@main
struct FollowersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UINavigationBar.appearance().tintColor = .systemGreen
                }
        }
    }
}
