//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import Foundation

enum ErrorMessage: String {	
	case invalidUsername = "The username created an invalid request. Please try again"
	case unableToCompleteRequest = "Unable to complete your request. Please check your internet connection"
	case invalidResponse = "The response received from the server was invalid. Please try again"
	case invalidData = "The data received from the server was invalid. Please try again"
}
