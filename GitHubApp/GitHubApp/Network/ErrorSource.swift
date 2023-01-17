//
//  ErrorSource.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

enum ErrorSource {
    case firstRequest
    case getRepoRequest
    
    var uniqueErrorCode: Int {
        switch self {
        case .firstRequest: return -10
        case .getRepoRequest: return -11
        }
    }
    
    var message: String {
        switch self {
        case .firstRequest:
            return "getRequestFails because of decoding Error"
            + " or expected body was nil,"
            + " check the Model and responce for source \(self)"
            
        case .getRepoRequest:
            return "getRepoRequest fails decoding error, model changed check Api"
        }
    }
}
