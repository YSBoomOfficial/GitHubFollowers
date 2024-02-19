//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 19/02/2024.
//

import UIKit

class SearchVC: UIViewController {
	let logoImageView = UIImageView()
	let usernameTextField = GFTextField()
	let ctaButton = GFButton(
		title: "Get Followers",
		backgroundColor: .systemGreen
	)
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		// `viewDidLoad` only called once when view loads
		// `viewWillAppear` called every time view appears
		// hiding nav bar in `viewWillAppear` hides it every time
		// hiding nav bar in `viewDidLoad` hides it only the first time the view loads
		
		navigationController?.isNavigationBarHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureLogoImageView()
		configureUsernameTextField()
		configureCTAButton()
	}
}


fileprivate extension SearchVC {
	func configureLogoImageView() {
		view.addSubview(logoImageView)
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = .init(named: "gh-logo")!
		
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	func configureUsernameTextField() {
		view.addSubview(usernameTextField)
		
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			usernameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func configureCTAButton() {
		view.addSubview(ctaButton)
		
		NSLayoutConstraint.activate([
			ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			ctaButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}
