//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class FollowerListVC: UIViewController {
	var username: String!
	var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		configureCollectionView()
		fetchFollowers()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	private func fetchFollowers() {
		NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
			guard let self else { return }
			
			switch result {
			case let .success(followers): print(followers)
			case let .failure(error):
				self.presentGFAlert(
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
	}
	
	func configureCollectionView() {
		collectionView = .init(frame: view.bounds, collectionViewLayout: create3ColumnFlowLayout())
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
	}
	
	func create3ColumnFlowLayout() -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minItemSpacing: CGFloat = 10
		let availableWidth = width - (2*padding) - (2*minItemSpacing)
		let itemWidth = availableWidth / 3
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = .init(width: itemWidth, height: itemWidth + 40)
		return flowLayout
	}
}

