//
//  GFError.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import Foundation

enum GFError: String, Error {
	case invalidUsername = "The username created an invalid request. Please try again"
	case unableToCompleteRequest = "Unable to complete your request. Please check your internet connection"
	case invalidResponse = "The response received from the server was invalid. Please try again"
	case invalidData = "The data received from the server was invalid. Please try again"
	
	case unableToFavourites = "Could not add user to favourites. Please try again."
	case alreadyInFavourites = "You have already favourited this user."
}
