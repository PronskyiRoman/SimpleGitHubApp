//
//  ContentViewModelProtocol.swift
//  GitHubApp
//
//  Created by -_- on 18.01.2023.
//

import Foundation

protocol ContentViewModelProtocol: ObservableObject {
    var coordinator: Coordinator { get set }
}
