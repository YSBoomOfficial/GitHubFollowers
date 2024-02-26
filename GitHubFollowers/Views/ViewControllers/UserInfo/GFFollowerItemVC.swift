//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 23/02/2024.
//

import Foundation

protocol GFFollowerItemVCDelegate: AnyObject {
	func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
	private weak var delegate: GFFollowerItemVCDelegate!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	init(user: User, delegate: GFFollowerItemVCDelegate) {
		self.delegate = delegate
		super.init(user: user)
	}
	
	override func didTapActionButton() {
		delegate.didTapGetFollowers(for: user)
	}
	
	private func configureItems() {
		itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
		itemInfoView2.set(itemInfoType: .following, withCount: user.following)
		actionButton.set(title: "Get Followers", backgroundColor: .systemGreen)
	}
}
