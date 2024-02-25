//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	convenience init(size: CGFloat) {
		self.init(frame: .zero)
		font = .systemFont(ofSize: size, weight: .medium)
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
	}
}
