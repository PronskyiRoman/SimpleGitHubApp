//
//  Date+iosFullString.swift
//  GitHubApp
//
//  Created by -_- on 19.01.2023.
//

import Foundation

extension Date {
    var iosFullString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }
}
