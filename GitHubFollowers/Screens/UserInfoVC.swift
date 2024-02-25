//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
	func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
	var username: String!
	
	let headerView = UIView()
	let itemView1 = UIView()
	let itemView2 = UIView()
	let dateLabel = GFBodyLabel(alignment: .center)
	
	weak var delegate: UserInfoVCDelegate!
	
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
		navigationItem.rightBarButtonItem = .init(
			barButtonSystemItem: .done,
			target: self,
			action: #selector(dismissVC)
		)
	}
	
	func configureSubviews() {
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 140
		
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
			headerView.heightAnchor.constraint(equalToConstant: 210),
			
			itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
			
			itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
			itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
			
			dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func addSections(for user: User) {
		self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		
		let repoItemVC = GFRepoItemVC(user: user, delegate: self)
		self.add(childVC: repoItemVC, to: self.itemView1)
		
		let followerItemVC = GFFollowerItemVC(user: user, delegate: self)
		self.add(childVC: followerItemVC, to: self.itemView2)
		
		self.dateLabel.text = "GitHub since " + user.createdAt.convertToMonthYearFormat()
	}
}

extension UserInfoVC: GFRepoItemVCDelegate {
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
}

extension UserInfoVC: GFFollowerItemVCDelegate {
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
