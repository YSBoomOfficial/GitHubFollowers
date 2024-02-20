//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 21/02/2024.
//

import UIKit

enum UIHelper {
	static func create3ColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minItemSpacing: CGFloat = 10
		let availableWidth = width - (2*padding) - (2*minItemSpacing)
		let itemWidth = availableWidth / 3
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = .init(width: itemWidth, height: itemWidth + 40)
		return flowLayout
	}
}
