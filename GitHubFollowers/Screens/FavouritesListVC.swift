//
//  FavouritesListVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class FavouritesListVC: UIViewController {
	let tableView = UITableView()
	
	var favourites = [Follower]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		configureTableView()
		getFavourites()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavourites()
	}
	
	func getFavourites() {
		PersistenceManager.retrieveFavourites { [weak self] result in
			guard let self else { return }
			
			switch result {
			case let .success(favourites):
				if favourites.isEmpty {
					DispatchQueue.main.async {
						self.showEmptyStateView(
							with: "No Favourites?\nAdd one on the follower screen.",
							in: self.view
						)
					}
				} else {
					self.favourites = favourites
					DispatchQueue.main.async {
						self.tableView.reloadData()
						self.view.bringSubviewToFront(self.tableView)
					}
				}
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

private extension FavouritesListVC {
	func configureVC() {
		view.backgroundColor = .systemBackground
		title = "Favourites"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func configureTableView() {
		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.rowHeight = 80
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseId)
	}
}

extension FavouritesListVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		favourites.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseId, for: indexPath) as! FavouriteCell
		cell.set(favourite: favourites[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favourite = favourites[indexPath.row]
		let destination = FollowerListVC()
		destination.username = favourite.login
		destination.title = favourite.login
		navigationController?.pushViewController(destination, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		let favourite = favourites[indexPath.row]
		favourites.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .left)
		
		PersistenceManager.updateWith(favourite: favourite, actionType: .remove) { [weak self] error in
			guard let self, let error else { return }
			presentGFAlert(
				title: "Something went wrong",
				message: error.rawValue,
				buttonTitle: "Ok"
			)
		}
	}
}
