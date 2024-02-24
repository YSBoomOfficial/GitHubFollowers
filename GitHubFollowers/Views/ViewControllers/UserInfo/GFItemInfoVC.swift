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
	
	weak var delegate: UserInfoVCDelegate!
	
	private let padding: CGFloat = 20
	
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
		configureStackView()
		configureActionButton()
	}
	
	@objc func didTapActionButton() {
		fatalError("Subclass must ovveride this method")
	}
}

private extension GFItemInfoVC {
	func configureVC() {
		view.layer.cornerRadius = 18
		view.backgroundColor = .secondarySystemBackground
	}
	
	func configureStackView() {
		view.addSubview(stackView)
		stackView.addArrangedSubview(itemInfoView1)
		stackView.addArrangedSubview(itemInfoView2)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			stackView.heightAnchor.constraint(equalToConstant: 50),
		])
	}
	
	func configureActionButton() {
		view.addSubview(actionButton)
		actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
	
		NSLayoutConstraint.activate([
			actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44),
		])
	}
}
