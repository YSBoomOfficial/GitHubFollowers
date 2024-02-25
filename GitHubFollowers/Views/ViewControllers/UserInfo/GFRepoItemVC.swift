//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 23/02/2024.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
	func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
	
	var delegate: GFRepoItemVCDelegate!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	init(user: User, delegate: GFRepoItemVCDelegate) {
		self.delegate = delegate
		super.init(user: user)
	}
	
	override func didTapActionButton() {
		delegate.didTapGitHubProfile(for: user)
	}
	
	func configureItems() {
		itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos)
		itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
		actionButton.set(title: "GitHub Profile", backgroundColor: .systemPurple)
	}
}
