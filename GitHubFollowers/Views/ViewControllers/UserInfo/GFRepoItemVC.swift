//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 23/02/2024.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}

}

private extension GFRepoItemVC {
	func configureItems() {
		itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos)
		itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
		actionButton.set(title: "GitHub Profile", backgroundColor: .systemPurple)
	}
}
