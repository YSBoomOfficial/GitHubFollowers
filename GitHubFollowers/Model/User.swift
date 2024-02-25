//
//  User.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import Foundation

struct User: Codable {
	let login: String
	let avatarUrl: String
	let name: String?
	let location: String?
	let bio: String?
	let publicGists: Int
	let publicRepos: Int
	let htmlUrl: String
	let following: Int
	let followers: Int
	let createdAt: Date
}
