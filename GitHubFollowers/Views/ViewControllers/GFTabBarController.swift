//
//  GFTabBarController.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 25/02/2024.
//

import UIKit

class GFTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		UITabBar.appearance().tintColor = .systemGreen
		viewControllers = [createSearchNavController(), createFavouritesListNavController()]
	}
	
	private func createSearchNavController() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = "Search"
		searchVC.tabBarItem = .init(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}
	
	private func createFavouritesListNavController() -> UINavigationController {
		let favouritesListVC = FavouritesListVC()
		favouritesListVC.title = "Favourites"
		favouritesListVC.tabBarItem = .init(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favouritesListVC)
	}
}
