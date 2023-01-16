//
//  NetworkCore.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

final class NetworkCore {
    // MARK: Private Property
    private let session: APISession = .shared
    
    // MARK: Private func
    private func dataRequest<D: Descriptor>(for descriptor: D) async throws -> D.Response? {
        let response = try await session.makeRequest(for: descriptor)
        switch response.statusCode {
        case .success: return response.getData()
        default: throw response.statusCode
        }
    }
    
    // MARK: Public interface
    func request<D: Descriptor>(for descriptor: D, source: ErrorSource) async throws -> D.Response {
        guard let response = try await dataRequest(for: descriptor) else {
            throw NetworkError.unknown((nil, source.message, source.uniqueErrorCode))
        }
        
        return response
    }
}
