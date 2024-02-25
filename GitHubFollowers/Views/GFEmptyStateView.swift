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
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	convenience init(message: String) {
		self.init(frame: .zero)
		messageLabel.text = message
	}
	
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}

	private func configureMessageLabel() {
		messageLabel.numberOfLines = 3
		messageLabel.textColor = .secondaryLabel

		let labelCentreYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -50 : -150
		
		NSLayoutConstraint.activate([
			messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: labelCentreYConstant),
			messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
			messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
			messageLabel.heightAnchor.constraint(equalToConstant: 200),
		])
	}
	
	private func configureLogoImageView() {
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = Images.emptyState
		
		let imageViewBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
		
		NSLayoutConstraint.activate([
			logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
			logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
			logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
			logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: imageViewBottomConstant)
		])
	}
	
	private func configure() {
		addSubviews(messageLabel, logoImageView)
		configureMessageLabel()
		configureLogoImageView()
	}
}
