//
//  Descriptor.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

protocol Descriptor {
    associatedtype Response: Codable
    
    var metgod: HttpMethod { get }
    var endPointPath: String { get }
    var queryItems: [String: String] { get }
    var headers: [String: String] { get }
    var response: UrlResponse<Response> { get }
}

extension Descriptor {
    var response: UrlResponse<Response> { .init() }
    var endPointPath: String { "" }
    var queryItems: [String: String] { [:] }
    var headers: [String: String] { [:] }
}
