//
//  Coordinator.swift
//  GitHubApp
//
//  Created by -_- on 18.01.2023.
//

import SwiftUI

final class Coordinator: ObservableObject {
    // navigation path
    @Published var path: NavigationPath = NavigationPath()
    
    static let shared: Coordinator = { Coordinator() }()
    
    // private init
    private init() { }
    
    func push(_ path: CoordinatorPath) {
        self.path.append(path)
    }
}
