//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class FollowerListVC: UIViewController {
	enum Section {
		case main
	}
	
	var collectionView: UICollectionView!
	var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
	
	var followers = [Follower]()
	
	var username: String!
	var hasMoreFollowers = true
	var currentPage = 1
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		configureCollectionView()
		configureDataSource()
		fetchFollowers(for: username, page: currentPage)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	private func fetchFollowers(for username: String, page: Int) {
		// [weak self] needed as NetworkManager has strong the VC
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			guard let self else { return }
			
			switch result {
			case let .success(fetchedFollowers):
				if fetchedFollowers.count < 100 { hasMoreFollowers = false }
				followers.append(contentsOf: fetchedFollowers)
				updateData()
			case let .failure(error):
				presentGFAlert(
					title: "Something went wrong",
					message: error.rawValue,
					buttonTitle: "Ok"
				)
			}
		}
	}
	
	private func updateData() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async {
			self.datasource.apply(snapshot, animatingDifferences: true)
		}
	}
}

private extension FollowerListVC {
	func configureVC() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
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
}

extension FollowerListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY         = scrollView.contentOffset.y
		let contentHeight   = scrollView.contentSize.height
		let height          = scrollView.frame.size.height
		
		if offsetY > (contentHeight - height) && hasMoreFollowers {
			currentPage += 1
			fetchFollowers(for: username, page: currentPage)
		}
	}
}
