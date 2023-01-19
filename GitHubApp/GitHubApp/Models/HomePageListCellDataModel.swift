//
//  HomePageListCellDataModel.swift
//  GitHubApp
//
//  Created by -_- on 18.01.2023.
//

import Foundation

struct HomePageListCellDataModel: Hashable {
    let name: String
    let description: String
    let profileImageUrl: String
    let language: String
    let repoUrl: String
    var created: Date?
    var updated: Date?
}
