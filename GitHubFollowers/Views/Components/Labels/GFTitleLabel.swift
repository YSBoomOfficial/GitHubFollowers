//
//  GFTitleLabel.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class GFTitleLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	convenience init(alignment: NSTextAlignment, fontSize: CGFloat) {
		self.init(frame: .zero)
		textAlignment = alignment
		font = .systemFont(ofSize: fontSize, weight: .bold)
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .label
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
	}
}
