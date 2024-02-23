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
	let itemView1 = UIView()
	let itemView2 = UIView()
	let dateLabel = GFBodyLabel(alignment: .center)
	
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
					self.add(childVC: GFRepoItemVC(user: user), to: self.itemView1)
					self.add(childVC: GFFollowerItemVC(user: user), to: self.itemView2)
					self.dateLabel.text = "GitHub since " + user.createdAt.convertToFormattedDateString()
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
		let padding: CGFloat = 20
		
		for itemView in [headerView, itemView1, itemView2, dateLabel] {
			view.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			])
		}
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
			headerView.heightAnchor.constraint(equalToConstant: 180),
			
			itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemView1.heightAnchor.constraint(equalToConstant: 140),
			
			itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
			itemView2.heightAnchor.constraint(equalToConstant: 140),
			
			dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}
