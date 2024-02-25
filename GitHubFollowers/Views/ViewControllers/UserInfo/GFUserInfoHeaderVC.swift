//
//  GFUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
	var user: User!
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(alignment: .left, fontSize: 34)
	let nameLabel = GFSecondaryTitleLabel(size: 18)
	let locationImageView = UIImageView()
	let locationLabel = GFSecondaryTitleLabel(size: 18)
	let bioLabel = GFBodyLabel(alignment: .left)
	
	private let textImagePadding: CGFloat = 12
	
	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureSubviews()
	}
	
}

private extension GFUserInfoHeaderVC {
	func configureSubviews() {
		configureAvatarImageView()
		configureUsernameLabel()
		configureNameLabel()
		configureLocationImageView()
		configureLocationLabel()
		configureBioLabel()
	}

	func configureAvatarImageView() {
		view.addSubview(avatarImageView)
		NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] downloadedImage in
			guard let self else { return }
			DispatchQueue.main.async { self.avatarImageView.image = downloadedImage  }
		}
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			avatarImageView.widthAnchor.constraint(equalToConstant: 90),
			avatarImageView.heightAnchor.constraint(equalToConstant: 90)
		])
	}
	
	func configureUsernameLabel() {
		view.addSubview(usernameLabel)
		usernameLabel.text = user.login
		
		NSLayoutConstraint.activate([
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			usernameLabel.heightAnchor.constraint(equalToConstant: 38)
		])
	}
	
	func configureNameLabel() {
		view.addSubview(nameLabel)
		nameLabel.text = user.name
		
		NSLayoutConstraint.activate([
			nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
			nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			nameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
	
	func configureLocationImageView() {
		view.addSubview(locationImageView)
		locationImageView.translatesAutoresizingMaskIntoConstraints = false
		locationImageView.image = .init(systemName: SFSymbols.location)!
		locationImageView.tintColor = .secondaryLabel
		
		NSLayoutConstraint.activate([
			locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
			locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			locationImageView.widthAnchor.constraint(equalToConstant: 20),
			locationImageView.heightAnchor.constraint(equalToConstant: 20)
		])
	}
	
	func configureLocationLabel() {
		view.addSubview(locationLabel)
		locationLabel.text = user.location ?? "No Location"
		
		NSLayoutConstraint.activate([
			locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
			locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
	
	func configureBioLabel() {
		view.addSubview(bioLabel)
		bioLabel.text = user.bio
		bioLabel.numberOfLines = 3
		
		NSLayoutConstraint.activate([
			bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
			bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bioLabel.heightAnchor.constraint(equalToConstant: 80)
		])
	}
}
