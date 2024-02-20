//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class GFButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	init(title: String, backgroundColor: UIColor) {
		super.init(frame: .zero)
		self.setTitle(title, for: .normal)
		self.backgroundColor = backgroundColor
		configure()
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 10
		setTitleColor(.white, for: .normal)
		titleLabel?.font = .preferredFont(forTextStyle: .headline)
	}
}
