//
//  RepoDataContainer.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

struct RepoDataContainer: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepoDataModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct RepoDataModel: Codable {
    let updatedAt, gitUrl, createdAt: String
    let description, language: String?
    let id: Int
    let owner: RepoOwner
    
    
    enum CodingKeys: String, CodingKey {
        case gitUrl = "git_url"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, description, owner, language
    }
}

struct RepoOwner: Codable {
    let login, avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login
    }
}
