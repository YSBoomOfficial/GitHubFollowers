//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import UIKit

class NetworkManager {
	static let shared = NetworkManager()
	private let baseEndpoint = "https://api.github.com/users"
	
	let cache = NSCache<NSString, UIImage>()
	
	private init() {}
	
	func getFollowers(
		for username: String,
		page: Int,
		completion: @escaping (Result<[Follower], GFError>) -> Void
	) {
		let endpoint = "\(baseEndpoint)/\(username)/followers?per_page=100page=\(page)"
		print("Calling Endpoint: \(endpoint)")
		
		guard let url = URL(string: endpoint) else {
			completion(.failure(.invalidUsername))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard error == nil else {
				completion(.failure(.unableToCompleteRequest))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(.failure(.invalidResponse))
				return
			}
			
			guard let data else {
				completion(.failure(.invalidData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let followers = try decoder.decode([Follower].self, from: data)
				completion(.success(followers))
			} catch {
				print("Decoding Error: \(error.localizedDescription)")
				completion(.failure(.invalidData))
				return
			}
		}.resume()
	}
}
