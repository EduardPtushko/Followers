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
            "This username created an invalid request. Please try again."
        case .invalidResponse:
            "Invalid response from the server. Please try again."
        case .invalidData:
            "The data received from the server was invalid. Please try again."
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
