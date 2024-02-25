//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
	func didRequestFollowers(for username: String)
}

class FollowerListVC: GFDataLoadingVC {
	enum Section { case main }
	
	var collectionView: UICollectionView!
	var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
	
	var followers = [Follower]()
	var filteredFollowers = [Follower]()
	
	var username: String!
	var hasMoreFollowers = true
	var currentPage = 1
	
	var isSearching = false
	
	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		self.username = username
		title = username
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		configureCollectionView()
		configureDataSource()
		configureSearchController()
		getFollowers(for: username, page: currentPage)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	private func getFollowers(for username: String, page: Int) {
		// [weak self] needed as NetworkManager has strong the VC
		showLoadingView()
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			guard let self else { return }
			hideLoadingView()
			
			switch result {
			case let .success(fetchedFollowers):
				if fetchedFollowers.count < 100 { hasMoreFollowers = false }
				followers.append(contentsOf: fetchedFollowers)
				
				if followers.isEmpty {
					DispatchQueue.main.async {
						self.showEmptyStateView(
							with: "This user doesn't have any followers. Go follow them 😀",
							in: self.view
						)
					}
				} else {
					updateData(with: followers)
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
	
	private func updateData(with followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async {
			self.datasource.apply(snapshot, animatingDifferences: true)
		}
	}
	
	@objc func addButtonTapped() {
		showLoadingView()
		NetworkManager.shared.getUser(for: username) { [weak self] result in
			guard let self else { return }
			hideLoadingView()
			
			switch result {
			case let .success(user):
				let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
				PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
					guard let self else { return }
					
					let (alertTitle, alertMessage) = if let error {
						("Something went wrong", error.rawValue)
					} else {
						("Success", "You have successfully added \"\(favourite.login)\" to your favourites 🎉! ")
					}
					
					presentGFAlert(title: alertTitle, message: alertMessage, buttonTitle: "Ok")
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

private extension FollowerListVC {
	func configureVC() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.rightBarButtonItem = .init(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(addButtonTapped)
		)
	}
	
	func configureCollectionView() {
		collectionView = .init(
			frame: view.bounds,
			collectionViewLayout: UIHelper.create3ColumnFlowLayout(in: view)
		)
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
		collectionView.delegate = self
	}
	
	func configureDataSource() {
		datasource = .init(collectionView: collectionView) { collectionView, indexPath, follower in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			return cell
		}
	}
	
	func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search for a username"
		navigationItem.searchController = searchController
	}
}

extension FollowerListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY         = scrollView.contentOffset.y
		let contentHeight   = scrollView.contentSize.height
		let height          = scrollView.frame.size.height
		
		if offsetY > (contentHeight - height) && hasMoreFollowers {
			currentPage += 1
			getFollowers(for: username, page: currentPage)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let activeArray = isSearching ? filteredFollowers : followers
		let follower = activeArray[indexPath.item]
		
		let userInfoVC = UserInfoVC()
		userInfoVC.username = follower.login
		userInfoVC.delegate = self
		
		let navigationController = UINavigationController(rootViewController: userInfoVC)
		present(navigationController, animated: true)
	}
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
		isSearching = true
		filteredFollowers = followers.filter { $0.login.localizedCaseInsensitiveContains(filter) }
		updateData(with: filteredFollowers)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		isSearching = false
		updateData(with: followers)
	}
}

extension FollowerListVC: FollowerListVCDelegate {
	func didRequestFollowers(for username: String) {
		self.username = username
		currentPage = 1
		title = username
		followers.removeAll()
		filteredFollowers.removeAll()
		collectionView.setContentOffset(.zero, animated: true)
		getFollowers(for: username, page: 1)
	}
}
