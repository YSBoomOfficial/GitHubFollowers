//
//  FavouriteCell.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 25/02/2024.
//

import UIKit

class FavouriteCell: UITableViewCell {
	static let reuseId = "FavouriteCell"
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(alignment: .left, fontSize: 26)
	private let padding: CGFloat = 12
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	func set(favourite: Follower) {
		usernameLabel.text = favourite.login
		NetworkManager.shared.downloadImage(from: favourite.avatarUrl) { [weak self] downloadedImage in
			guard let self else { return }
			DispatchQueue.main.async { self.avatarImageView.image = downloadedImage  }
		}
	}
	
	private func configure() {
		accessoryType = .disclosureIndicator
		
		addSubview(avatarImageView)
		addSubview(usernameLabel)
		
		NSLayoutConstraint.activate([
			avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			avatarImageView.heightAnchor.constraint(equalToConstant: 60),
			avatarImageView.widthAnchor.constraint(equalToConstant: 60),
			
			usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
			usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 40)
			
		])
	}
	
}
