//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 23/02/2024.
//

import Foundation

extension Date {
	func convertToMonthYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		return dateFormatter.string(from: self)
	}
}
