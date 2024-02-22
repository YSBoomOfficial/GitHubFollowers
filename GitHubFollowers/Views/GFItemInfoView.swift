//
//  GFItemInfoView.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

class GFItemInfoView: UIView {
	enum ItemInfoType {
		case repos, gists, followers, following
	}
	
	let symbolImageView = UIImageView()
	let titleLabel = GFTitleLabel(alignment: .left, fontSize: 14)
	let countLabel = GFTitleLabel(alignment: .center, fontSize: 14)
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		configrue()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	func set(itemInfoType: ItemInfoType, withCount count: Int) {
		switch itemInfoType {
		case .repos:
			symbolImageView.image = .init(systemName: SFSymbols.repos)
			titleLabel.text = "Public Repos"
		case .gists:
			symbolImageView.image = .init(systemName: SFSymbols.gists)
			titleLabel.text = "Public Gists"
		case .followers:
			symbolImageView.image = .init(systemName: SFSymbols.followers)
			titleLabel.text = "Followers"
		case .following:
			symbolImageView.image = .init(systemName: SFSymbols.following)
			titleLabel.text = "Following"
		}
		countLabel.text = "\(count)"
	}
	
	private func configrue() {
		addSubview(symbolImageView)
		addSubview(titleLabel)
		addSubview(countLabel)
		
		symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		symbolImageView.contentMode = .scaleAspectFill
		symbolImageView.tintColor = .label
		
		NSLayoutConstraint.activate([
			symbolImageView.topAnchor.constraint(equalTo: topAnchor),
			symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			symbolImageView.widthAnchor.constraint(equalToConstant: 20),
			symbolImageView.heightAnchor.constraint(equalToConstant: 20),
			
			titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			titleLabel.heightAnchor.constraint(equalToConstant: 18),
			
			countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
			countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			countLabel.heightAnchor.constraint(equalToConstant: 18),
		])
	}
}