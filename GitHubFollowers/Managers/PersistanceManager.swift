//
//  PersistanceManager.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 24/02/2024.
//

import Foundation

enum PersistenceManager {
	private static let userDefaults = UserDefaults.standard
	
	private enum Key {
		static let favourites = "favourites"
	}
	
	enum ActionType {
		case add, remove
	}
	
	static func retrieveFavourites(
		completion: @escaping (Result<[Follower], GFError>) -> Void
	) {
		guard let data = userDefaults.object(forKey: Key.favourites) as? Data else {
			completion(.success([]))
			return
		}
		
		do {
			let favourites = try JSONDecoder().decode([Follower].self, from: data)
			completion(.success(favourites))
		} catch {
			completion(.failure(.unableToFavourites))
		}
	}
	
	static func save(
		favourites: [Follower]
	) -> GFError? {
		do {
			let encodedFavourites = try JSONEncoder().encode(favourites)
			userDefaults.setValue(encodedFavourites, forKey: Key.favourites)
			return nil
		} catch {
			return .unableToFavourites
		}
	}
	
	static func updateWith(
		favourite: Follower,
		actionType: PersistenceManager.ActionType,
		completion: @escaping (GFError?) -> Void
	) {
		retrieveFavourites { result in
			switch result {
			case var .success(retrievedFavourites):
				switch actionType {
				case .add:
					guard !retrievedFavourites.contains(favourite) else {
						completion(.alreadyInFavourites)
						return
					}
					retrievedFavourites.append(favourite)
				case .remove: 
					retrievedFavourites.removeAll { $0.login == favourite.login }
				}
				
				completion(save(favourites: retrievedFavourites))
			case let .failure(error): completion(error)
			}
		}
	}
	
	static func removeAllFavourites() {
		userDefaults.removeObject(forKey: Key.favourites)
	}
}
