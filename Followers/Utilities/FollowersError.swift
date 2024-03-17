//
//  FollowersError.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import Foundation

enum FollowersError: Error, Equatable {
    case invalidUsername
    case unableToComplete
    case invalidResponse
    case invalidData
    case unableToFavorite
    case alreadyInFavorites
    case unableToRemove
    case unexpectedError
}

extension FollowersError: LocalizedError {
    var description: String {
        switch self {
        case .invalidUsername:
            NSLocalizedString("This username created an invalid request. Please try again.", comment: "invalid username error description")
        case .invalidResponse:
            NSLocalizedString("Invalid response from the server. Please try again.", comment: "invalid response error description")
        case .invalidData:
            NSLocalizedString("The data received from the server was invalid. Please try again.", comment: "invalid data error description")
        case .unableToComplete:
            NSLocalizedString("Unable to complete your request. Please check your internet connection", comment: "unable to complete error description")
        case .unexpectedError:
            NSLocalizedString("We were unable to complete your task at this time. Please try again.", comment: "unexpected error description")
        case .unableToFavorite:
            NSLocalizedString("There was an error favoriting this user. Please try again.", comment: "unable to favorite error description")
        case .alreadyInFavorites:
            NSLocalizedString("You've already favorited this user. You must really like them!", comment: "already in favorites error description")
        case .unableToRemove:
            NSLocalizedString("We were unable to remove from favorites. Please try again.", comment: "unable to remove error description")
        }
    }

    var title: String {
        switch self {
        case .invalidUsername:
            "Invalid Username"
        case .unableToComplete:
            "Bad Stuff Happened"
        case .invalidResponse:
            "Bad Stuff Happened"
        case .invalidData:
            "Bad Stuff Happened"
        case .unexpectedError:
            "Something went wrong"
        case .unableToFavorite:
            "Something went wrong"
        case .alreadyInFavorites:
            "Bad Stuff Happened"
        case .unableToRemove:
            "Unable to remove"
        }
    }
}
