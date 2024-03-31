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
    case unableToFavorite
    case alreadyInFavorites
    case unableToRemove
    case unexpectedError
    case networkError(NetworkError)
}

extension FollowersError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUsername:
            "This username created an invalid request. Please try again."
        case .unableToComplete:
            "Unable to complete your request. Please check your internet connection"
        case .unexpectedError:
            "We were unable to complete your task at this time. Please try again."
        case .unableToFavorite:
            "There was an error favoriting this user. Please try again."
        case .alreadyInFavorites:
            "You've already favorited this user. You must really like them!"
        case .unableToRemove:
            "We were unable to remove from favorites. Please try again."
        case .networkError(let error):
            error.errorDescription
        }
    }

    var title: String {
        switch self {
        case .invalidUsername:
            "Invalid Username"
        case .unexpectedError, .unableToFavorite:
            "Something went wrong"
        case .unableToRemove:
            "Unable to remove"
        case .alreadyInFavorites, .unableToComplete, .networkError:
            "Bad Stuff Happened"
        }
    }

    var buttonTitle: String {
        switch self {
        case .invalidUsername:
            "Ok"
        case .unableToComplete:
            "Ok"
        case .unableToFavorite:
            "Ok"
        case .alreadyInFavorites:
            "Ok"
        case .unableToRemove:
            "Ok"
        case .unexpectedError:
            "Ok"
        case .networkError:
            "Ok"
        }
    }
}
