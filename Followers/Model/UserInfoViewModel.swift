//
//  UserInfoViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import Foundation

@Observable
final class UserInfoViewModel {
    @ObservationIgnored let networkManager: NetworkManagerProtocol
    var user: User?
    var lastAlertMessage = "None" {
        didSet {
            isDisplayingAlert = true
        }
    }

    var isDisplayingAlert = false
    var alertTitle = "Something went wrong"

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    @MainActor
    func getUser(username: String) async {
        do {
            let user = try await networkManager.getUserInfo(for: username)
            self.user = user
        } catch {
            lastAlertMessage = error.localizedDescription
        }
    }
}
