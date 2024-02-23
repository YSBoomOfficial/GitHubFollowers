//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 23/02/2024.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
}

private extension GFFollowerItemVC {
	func configureItems() {
		itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
		itemInfoView2.set(itemInfoType: .following, withCount: user.following)
		actionButton.set(title: "Get Followers", backgroundColor: .systemGreen)
	}
}
