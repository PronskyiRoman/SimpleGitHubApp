//
//  ContentViewProtocol.swift
//  GitHubApp
//
//  Created by -_- on 18.01.2023.
//

import SwiftUI

protocol ContentViewProtocol {
    associatedtype ViewModel: ContentViewModelProtocol
    var viewModel: StateObject<ViewModel> { get }
    
    func buildBody() -> AnyView
    func buildHome() -> AnyView
}

extension ContentViewProtocol {
    func buildBody() -> AnyView {
        AnyView(buildHome()
            .environmentObject(viewModel.wrappedValue.coordinator))
    }
}
