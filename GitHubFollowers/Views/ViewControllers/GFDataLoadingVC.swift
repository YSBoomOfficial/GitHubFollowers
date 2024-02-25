//
//  GFDataLoadingVC.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 25/02/2024.
//

import UIKit

class GFDataLoadingVC: UIViewController {
	private var containerView = UIView()
	
	func showLoadingView() {
		view.addSubview(containerView)
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0
		
		UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
		])
		
		activityIndicator.startAnimating()
	}
	
	func hideLoadingView() {
		DispatchQueue.main.async {
			self.containerView.removeFromSuperview()
		}
	}
	
	func showEmptyStateView(
		with message: String,
		in view: UIView
	) {
		let emptyStateView = GFEmptyStateView(message: message)
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}
}
