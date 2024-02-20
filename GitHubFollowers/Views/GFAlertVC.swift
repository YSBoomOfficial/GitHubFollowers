//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import UIKit

class GFAlertVC: UIViewController {
	let containerView = UIView()
	let titleLabel = GFTitleLabel(alignment: .center, fontSize: 20)
	let messageLabel = GFBodyLabel(alignment: .center)
	let actionButton = GFButton(title: "Ok", backgroundColor: .systemPink)
	
	var alertTitle: String?
	var message: String?
	var buttonTitle: String?
	
	private let padding: CGFloat = 20
	
	init(alertTitle: String, message: String, buttonTitle: String) {
		super.init(nibName: nil, bundle: nil)
		self.alertTitle = alertTitle
		self.message = message
		self.buttonTitle = buttonTitle
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black.withAlphaComponent(0.75) // UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
		configure()
	}
	
	@objc private func dismissVC() {
		dismiss(animated: true)
	}
	
}

extension GFAlertVC {
	func configureContainerView() {
		view.addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false
		containerView.backgroundColor = .systemBackground
		containerView.layer.cornerRadius = 16
		containerView.layer.borderWidth = 2
		containerView.layer.borderColor = UIColor.white.cgColor
		
		NSLayoutConstraint.activate([
			containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			containerView.widthAnchor.constraint(equalToConstant: 280),
			containerView.heightAnchor.constraint(equalToConstant: 220)
		])
	}
	
	func configureTitleLabel() {
		containerView.addSubview(titleLabel)
		titleLabel.text = alertTitle ?? "Something Went Wrong"
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			titleLabel.heightAnchor.constraint(equalToConstant: 28)
		])
	}
	
	func configureBodyLabel() {
		containerView.addSubview(messageLabel)
		messageLabel.text = message ?? "Unable to complete request"
		messageLabel.numberOfLines = 4
		
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
		])
	}
	
	func configureActionButton() {
		containerView.addSubview(actionButton)
		actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
		actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
	
	func configure() {
		configureContainerView()
		
		configureTitleLabel()
		configureActionButton()
		
		// titleLabel and buttonLabel layout needs to happen before bodyLabel
		// since bodyLabel's top and bottom constraints depend on titleLabel and buttonLabel
		
		configureBodyLabel()
	}
}
 
