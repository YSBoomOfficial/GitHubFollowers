//
//  GFItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 22/02/2024.
//

import UIKit

class GFItemInfoVC: UIViewController {
	var user: User!
	
	let stackView = UIStackView()
	let itemInfoView1 = GFItemInfoView()
	let itemInfoView2 = GFItemInfoView()
	let actionButton = GFButton()
	
	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		configureSubviews()
	}
}

private extension GFItemInfoVC {
	func configureVC() {
		view.layer.cornerRadius = 18
		view.backgroundColor = .secondarySystemBackground
	}
	
	func configureSubviews() {
		let padding: CGFloat = 20
		
		view.addSubview(stackView)
		stackView.addArrangedSubview(itemInfoView1)
		stackView.addArrangedSubview(itemInfoView2)
		view.addSubview(actionButton)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			stackView.heightAnchor.constraint(equalToConstant: 50),
			
			actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44),
		])
	}
}
