//
//  FavouritesListVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class FavouritesListVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = "Favourites"
		
		PersistenceManager.retrieveFavourites { [weak self] result in
			guard let self else { return }
			
			switch result {
			case let .success(favourites):
				print(favourites)
			case let .failure(error):
				presentGFAlert(
					title: "Something went wrong",
					message: error.rawValue,
					buttonTitle: "Ok"
				)
			}
		}
		
	}
}

