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
		fetchUserInfo() 
	}
	
	private func fetchUserInfo() {
		NetworkManager.shared.getUser(for: username) { [weak self] result in
			guard let self else { return }
			
			switch result {
			case let .success(userInfo):
				print(userInfo)
			case let .failure(error):
				presentGFAlert(
					title: "Something went wrong",
					message: error.rawValue,
					buttonTitle: "Ok"
				)
			}
		}
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
