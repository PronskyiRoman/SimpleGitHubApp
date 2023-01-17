//
//  RepositoryService.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

final class RepositoryService: NetworkCore {
    func getRepoDataContainer(for query: String, and page: Int = 1) async throws -> RepoDataContainer {
        let descriptor = GetRepoDataContainer(query: query, page: page)
        return try await request(for: descriptor, source: .getRepoRequest)
    }
}
