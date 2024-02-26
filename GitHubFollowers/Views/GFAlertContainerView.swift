//
//  GFAlertContainerView.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 25/02/2024.
//

import UIKit

class GFAlertContainerView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .systemBackground
		layer.cornerRadius = 16
		layer.borderWidth = 2
		layer.borderColor = UIColor.white.cgColor
	}
}
