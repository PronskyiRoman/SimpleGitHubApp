//
//  ContentView.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import SwiftUI

struct ContentView: View, ContentViewProtocol {
    // view model
    var viewModel: StateObject<ContentViewModel>
    
    // coordinator
    @StateObject var coordinator: Coordinator
    
    // init
    init(viewModel: ContentViewModel = .init()) {
        self.viewModel = StateObject(wrappedValue: viewModel)
        _coordinator = StateObject(wrappedValue: viewModel.coordinator)
    }
    // body
    var body: some View {
        buildIosBody()
    }
    
    // builders
    @ViewBuilder func buildHome() -> AnyView {
        AnyView(HomePageView(viewModel: .init()))
    }
    
    @ViewBuilder func buildIosBody() -> AnyView {
        AnyView(NavigationStack(path: $coordinator.path) {
            buildBody()
                .navigationDestination(for: CoordinatorPath.self) { path in
                    path.destination
                }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
