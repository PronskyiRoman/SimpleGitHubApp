//
//  Data+getNSStringFromJson.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

extension Data {
    var getNSStringFromJson: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedJson = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        return prettyPrintedJson
    }
}
