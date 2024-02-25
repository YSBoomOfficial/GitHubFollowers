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
		configure()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	func set(follower: Follower) {
		usernameLabel.text = follower.login
		NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] downloadedImage in
			guard let self else { return }
			DispatchQueue.main.async { self.avatarImageView.image = downloadedImage  }
		}
	}
	
	private func configure() {
		addSubview(avatarImageView)
		addSubview(usernameLabel)
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
			usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}
