//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

class UserInfoVC: UIViewController {
	var username: String!
	
	let headerView = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		configureSubviews()
		fetchUserInfo()
	}
	
	private func fetchUserInfo() {
		NetworkManager.shared.getUser(for: username) { [weak self] result in
			guard let self else { return }
			
			switch result {
			case let .success(user):
				DispatchQueue.main.async {
					self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
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
	
	func configureSubviews() {
		configureHeaderView()
	}
	
	func configureHeaderView() {
		view.addSubview(headerView)
		headerView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 180)
		])
	}

}
