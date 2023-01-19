//
//  CoordinatorPath.swift
//  GitHubApp
//
//  Created by -_- on 18.01.2023.
//

import SwiftUI

enum CoordinatorPath: Hashable {
    case errorPage
    
    var destination: AnyView {
        switch self {
        case .errorPage: return AnyView(ErrorPage())
        }
    }
}
