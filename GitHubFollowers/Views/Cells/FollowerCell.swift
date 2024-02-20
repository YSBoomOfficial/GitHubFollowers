//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseId = "FollowerCell"
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(alignment: .center, fontSize: 16)
	private let padding: CGFloat = 8
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	func set(follower: Follower) {
		usernameLabel.text = follower.login
		// avatarImageView.image =
	}
	
	private func configure() {
		addSubview(avatarImageView)
		addSubview(usernameLabel)
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
			usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}
