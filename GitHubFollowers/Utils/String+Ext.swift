//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 23/02/2024.
//

import Foundation

extension String {
	func convertToDate() -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		return dateFormatter.date(from: self)
	}
	
	func convertToFormattedDateString() -> String {
		convertToDate()?.convertToMonthYearFormat() ?? "N/A"
	}
}
