//
//  GetRepoDataContainer.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

struct GetRepoDataContainer: Descriptor {
    typealias Response = RepoDataContainer
    
    var metgod: HttpMethod { .get }
    var headers: [String : String] {
        ["Accept": "application/vnd.github+json",
         //-H "Authorization: Bearer <YOUR-TOKEN>"\
//         "": "",
         "X-GitHub-Api-Version": "2022-11-28"]
    }
    var queryItems: [String : String]
    var endPointPath: String { "/search/repositories" }
    
    init(query: String, page: Int) {
        self.queryItems = ["q": query,
                           "page": page.description]
    }
}
