//
//  String+iosFullDate.swift
//  GitHubApp
//
//  Created by -_- on 19.01.2023.
//

import Foundation

extension String {
    var iosFullDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: self)
    }
}
