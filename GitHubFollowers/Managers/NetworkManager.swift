//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import UIKit

class NetworkManager {
	static let shared = NetworkManager()

	#warning("TODO: Refactor to use URL Components ")
	private let baseEndpoint = "https://api.github.com/users"
	
	let cache = NSCache<NSString, UIImage>()
	
	private init() {}
	
	func getFollowers(
		for username: String,
		page: Int,
		completion: @escaping (Result<[Follower], GFError>) -> Void
	) {
		let endpoint = "\(baseEndpoint)/\(username)/followers?per_page=100&page=\(page)"
			
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
				completion(.failure(.invalidData))
				return
			}
		}.resume()
	}
	
	func getUser(
		for username: String,
		completion: @escaping (Result<User, GFError>) -> Void
	) {
		let endpoint = "\(baseEndpoint)/\(username)"
		
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
				decoder.dateDecodingStrategy = .iso8601
				
				let user = try decoder.decode(User.self, from: data)
				completion(.success(user))
			} catch {
				completion(.failure(.invalidData))
				return
			}
		}.resume()
	}
	
	func downloadImage(
		from urlString: String,
		completion: @escaping (UIImage?) -> Void
	) {
		if let cachedImage = cache.object(forKey: urlString as NSString) {
			completion(cachedImage)
			return
		}
		
		guard let url = URL(string: urlString) else {
			completion(nil)
			return
		}
		
		URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self,
				  error == nil,
				  (response as? HTTPURLResponse)?.statusCode == 200,
				  let data, let downloadedImage = UIImage(data: data) else {
				completion(nil)
				return
			}
			
			cache.setObject(downloadedImage, forKey: urlString as NSString)
			completion(downloadedImage)
		}.resume()
	}
}
