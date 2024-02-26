//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 25/02/2024.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach(addSubview)
	}
	
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
		])
	}
}

extension UIStackView {
	func addArrangedSubviews(_ views: UIView...) {
		views.forEach(addArrangedSubview)
	}
}
