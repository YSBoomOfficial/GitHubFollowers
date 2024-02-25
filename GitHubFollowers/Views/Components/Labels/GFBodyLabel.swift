//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class GFBodyLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	convenience init(alignment: NSTextAlignment) {
		self.init(frame: .zero)
		textAlignment = alignment
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .secondaryLabel
		font = .preferredFont(forTextStyle: .body)
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.75
		lineBreakMode = .byWordWrapping
	}
}
