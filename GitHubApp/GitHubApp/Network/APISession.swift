//
//  APISession.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

final class APISession {
    private init () { }
    static var shared: APISession { APISession() }
}

extension APISession: SessionManager {
    var session: URLSession { URLSession.shared }
    var url: String { "https://api.github.com" }
}
