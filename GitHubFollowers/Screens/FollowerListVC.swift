//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
	private enum Section { case main }
	
	private var collectionView: UICollectionView!
	private var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
	
	private var followers = [Follower]()
	private var filteredFollowers = [Follower]()
	
	private var username: String
	
	private var isLoadingMoreFollowers = true
	private var hasMoreFollowers = true
	private var currentPage = 1
	
	private var isSearching = false
	
	init(username: String) {
		self.username = username
		super.init(nibName: nil, bundle: nil)
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
		isLoadingMoreFollowers = true
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			guard let self else { return }
			hideLoadingView()
			
			switch result {
			case let .success(fetchedFollowers): updateUI(with: fetchedFollowers)
			case let .failure(error): presentGFAlert(error: error)
			}
			
			isLoadingMoreFollowers = false
		}
	}
	
	private func updateUI(with fetchedFollowers: [Follower]) {
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
	}
	
	private func updateData(with followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async {
			self.datasource.apply(snapshot, animatingDifferences: true)
		}
	}
	
	@objc private func addButtonTapped() {
		showLoadingView()
		NetworkManager.shared.getUser(for: username) { [weak self] result in
			guard let self else { return }
			hideLoadingView()
			
			switch result {
			case let .success(user): addUserToFavourites(user: user)
			case let .failure(error): presentGFAlert(error: error)
			}
		}
	}
	
	private func addUserToFavourites(user: User) {
		let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
		PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
			guard let self else { return }
			if let error {
				presentGFAlert(error: error)
			} else {
				presentGFAlert(
					title: "Success",
					message: "You have successfully added \"\(favourite.login)\" to your favourites 🎉!",
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
		searchController.searchBar.placeholder = "Search for a username"
		navigationItem.searchController = searchController
	}
}

extension FollowerListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		guard !isSearching else { return }
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height
		let hasScrolledToBottom = offsetY > (contentHeight - height)
		
		if hasScrolledToBottom && hasMoreFollowers && !isLoadingMoreFollowers {
			currentPage += 1
			getFollowers(for: username, page: currentPage)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let activeArray = isSearching ? filteredFollowers : followers
		let follower = activeArray[indexPath.item]
		
		let userInfoVC = UserInfoVC(username: follower.login, delegate: self)		
		let navigationController = UINavigationController(rootViewController: userInfoVC)
		present(navigationController, animated: true)
	}
}

extension FollowerListVC: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else {
			filteredFollowers.removeAll()
			updateData(with: followers)
			isSearching = false
			return
		}
		isSearching = true
		filteredFollowers = followers.filter { $0.login.localizedCaseInsensitiveContains(filter) }
		updateData(with: filteredFollowers)
	}
}

extension FollowerListVC: UserInfoVCDelegate {
	func didRequestFollowers(for username: String) {
		self.username = username
		currentPage = 1
		title = username
		followers.removeAll()
		filteredFollowers.removeAll()
		collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .top, animated: true)
		getFollowers(for: username, page: 1)
	}
}
