//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import Foundation

class NetworkManager {
	static let shared = NetworkManager()
	
	private let baseEndpoint = "https://api.github.com/users"
	
	private init() {}
	
	func getFollowers(
		for username: String,
		page: Int,
		completion: @escaping ([Follower]?, String?) -> Void
	) {
		let endpoint = "\(baseEndpoint)/\(username)/followers?per_page=100page=\(page)"
		print("Calling Endpoint: \(endpoint)")
		
		guard let url = URL(string: endpoint) else {
			completion(nil, "The username created an invalid request. Please try again")
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard error == nil else {
				completion(nil, "Unable to complete your request. Please check your internet connection")
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(nil, "Invalid response form the server. Please try again")
				return
			}
			
			guard let data else {
				completion(nil, "The data received from the server was invalid. Please try again")
				return
			}
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let followers = try decoder.decode([Follower].self, from: data)
				completion(followers, nil)
			} catch {
				print("Decoding Error: \(error.localizedDescription)")
				completion(nil, "The data received from the server was invalid. Please try again")
				return
			}
		}.resume()
	}
}
