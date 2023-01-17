//
//  SessionManager.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

protocol SessionManager {
    var session: URLSession { get }
    var url: String { get }
    
    func makeRequest<D: Descriptor>(for descriptor: D) async throws -> UrlResponse<D.Response>
}

extension SessionManager {
    func makeRequest<D: Descriptor>(for descriptor: D) async throws -> UrlResponse<D.Response> {
        try await request(for: descriptor)
    }
}

private extension SessionManager {
    private func constructUrl<D: Descriptor>(for descriptor: D) -> URL {
        guard let baseUrl = URL(string: url) else {
            preconditionFailure("Incorrect baseUrl!")
        }
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        components?.path += descriptor.endPointPath
        components?.queryItems = descriptor.queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else {
            preconditionFailure("Incorrect url!")
        }
        
        return url
    }
    
    private func constructRequest<D: Descriptor>(for descriptor: D) -> URLRequest {
        let url = constructUrl(for: descriptor)
        return RequestConfigurator().configure(url, descriptor: descriptor)
    }
    
    private func request<D: Descriptor>(for descriptor: D) async throws -> UrlResponse<D.Response> {
        let request = constructRequest(for: descriptor)
        let (data, response) = try await session.data(for: request)
        return descriptor.response.update(selfBy: data, and: (response as? HTTPURLResponse)?.statusCode)
    }
}
