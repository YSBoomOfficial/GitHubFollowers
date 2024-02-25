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
	
	var isUserNameEntered: Bool {
		!usernameTextField.text!.isEmpty
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		// `viewDidLoad` only called once when view loads
		// `viewWillAppear` called every time view appears
		// hiding nav bar in `viewWillAppear` hides it every time
		// hiding nav bar in `viewDidLoad` hides it only the first time the view loads
		
		navigationController?.setNavigationBarHidden(true, animated: true)
		usernameTextField.text = ""
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		configureLogoImageView()
		configureUsernameTextField()
		configureCTAButton()
		
		createDismissKeyboardTapGesture()
	}
	
	@objc private func pushFollowerListVC() {
		guard isUserNameEntered else {
			presentGFAlert(
				title: "Empty username",
				message: "Please enter a username. We need to know who to look for 😀.",
				buttonTitle: "Ok"
			)
			return
		}
		let followerListVC = FollowerListVC(username: usernameTextField.text!)
		view.endEditing(true)
		navigationController?.pushViewController(followerListVC, animated: true)
	}
}

fileprivate extension SearchVC {
	func configureLogoImageView() {
		view.addSubview(logoImageView)
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = Images.ghLogo
		
		let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
		
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	func configureUsernameTextField() {
		view.addSubview(usernameTextField)
		usernameTextField.delegate = self
		
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			usernameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func configureCTAButton() {
		view.addSubview(ctaButton)
		ctaButton.addTarget(
			self,
			action: #selector(pushFollowerListVC),
			for: .touchUpInside
		)
		
		NSLayoutConstraint.activate([
			ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			ctaButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func createDismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
		view.addGestureRecognizer(tap)
	}
}

extension SearchVC: UISearchTextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pushFollowerListVC()
		return true
	}
}
