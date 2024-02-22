//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

class GFEmptyStateView: UIView {
	let messageLabel = GFTitleLabel(alignment: .center, fontSize: 28)
	let logoImageView = UIImageView()
	
	init(message: String) {
		super.init(frame: .zero)
		messageLabel.text = message
		configure()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}

	private func configure() {
		addSubview(messageLabel)
		addSubview(logoImageView)
		
		messageLabel.numberOfLines = 3
		messageLabel.textColor = .secondaryLabel
		
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = .init(named: Images.emptyState)!
		
		NSLayoutConstraint.activate([
			messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
			messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
			messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
			messageLabel.heightAnchor.constraint(equalToConstant: 200),
			
			logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
			logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
			logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
			logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
		])
	}
}
