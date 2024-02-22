//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

class UserInfoVC: UIViewController {
	
	var username: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
	}
	
	@objc private func dismissModal() {
		dismiss(animated: true)
	}
	
}

private extension UserInfoVC {
	
	func configureVC() {
		view.backgroundColor = .systemBackground
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Done",
			style: .done,
			target: self,
			action: #selector(dismissModal)
		)
	}

}
