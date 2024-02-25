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
}

extension UIStackView {
	func addArrangedSubviews(_ views: UIView...) {
		views.forEach(addArrangedSubview)
	}
}
