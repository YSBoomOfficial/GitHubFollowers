//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
	func didTapGitHubProfile(for user: User)
	func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
	var username: String!
	
	let headerView = UIView()
	let itemView1 = UIView()
	let itemView2 = UIView()
	let dateLabel = GFBodyLabel(alignment: .center)
	
	weak var delegate: FollowerListVCDelegate!
	
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
					self.addSections(for: user)
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
	
	@objc private func dismissVC() {
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
			action: #selector(dismissVC)
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
	
	func addSections(for user: User) {
		self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		
		let repoItemVC = GFRepoItemVC(user: user)
		repoItemVC.delegate = self
		self.add(childVC: repoItemVC, to: self.itemView1)
		
		let followerItemVC = GFFollowerItemVC(user: user)
		followerItemVC.delegate = self
		self.add(childVC: followerItemVC, to: self.itemView2)
		
		self.dateLabel.text = "GitHub since " + user.createdAt.convertToFormattedDateString()
	}
}

extension UserInfoVC: UserInfoVCDelegate {
	func didTapGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlert(
				title: "Invalid URL",
				message: "The URL attached to this user is invalid",
				buttonTitle: "Ok"
			)
			return
		}
		presentSafariVC(with: url)
	}
	
	func didTapGetFollowers(for user: User) {
		guard user.followers > 0 else {
			presentGFAlert(
				title: "No Followers",
				message: "This User has no followers. What a shame 😞",
				buttonTitle: "So Sad"
			)
			return
		}
		delegate.didRequestFollowers(for: user.login)
		dismissVC()
	}
}
