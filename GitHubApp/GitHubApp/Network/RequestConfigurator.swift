//
//  RequestConfigurator.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

final class RequestConfigurator {
    // MARK: Publick func
    func configure<D: Descriptor>(_ url: URL, descriptor: D) -> URLRequest {
        var request = URLRequest(url: url)
        // confifure method
        confifureMethod(&request, descriptor: descriptor)
        
        // confifure headers
        confifureHeaders(&request, descriptor: descriptor)
        
        return request
    }
    
    // MARK: Private Func
    // confifure headers
    private func confifureHeaders<D: Descriptor>(_ request: inout URLRequest, descriptor: D) {
        guard !descriptor.headers.isEmpty else { return }
        descriptor.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
    }
    
    // confifure method
    private func confifureMethod<D: Descriptor>(_ request: inout URLRequest, descriptor: D) {
        request.httpMethod = descriptor.metgod.rawValue
    }
}
