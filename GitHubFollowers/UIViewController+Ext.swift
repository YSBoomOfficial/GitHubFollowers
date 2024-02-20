//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import UIKit

extension UIViewController {
	func presentGFAlert(title: String, message: String, buttonTitle: String) {
		let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
		alertVC.modalPresentationStyle = .overFullScreen
		alertVC.modalTransitionStyle = .crossDissolve
		DispatchQueue.main.async {
			self.present(alertVC, animated: true)
		}
		
	}
}
