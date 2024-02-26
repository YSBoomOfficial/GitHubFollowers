//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import UIKit

class GFAvatarImageView: UIImageView {	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	func downloadImage(fromUrl urlString: String) {
		NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
			guard let self else { return }
			DispatchQueue.main.async { self.image = image }
		}
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 10
		clipsToBounds = true
		image = Images.avatarPlaceholder
	}
}
