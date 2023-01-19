//
//  HomePageView.swift
//  GitHubApp
//
//  Created by -_- on 17.01.2023.
//

import SwiftUI

struct HomePageView: View, HomePageViewProtocol {
    // view model
    var viewModel: StateObject<HomePageViewModel>
    @EnvironmentObject var coordinator: Coordinator
    
    // init
    init(viewModel: HomePageViewModel) {
        self.viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // body
    var body: some View {
        buildIosBody()
    }
    
    // builders
    @ViewBuilder func buildIosBody() -> some View {
        buildList()
    }
    
    @ViewBuilder func buildCell(for item: HomePageListCellDataModel) -> AnyView {
        AnyView(HomePageListCell(viewModel: .init(model: item)))
    }
    
    @ViewBuilder func buildEmptyResponceView() -> AnyView {
        AnyView(EmptyResponceView())
    }
    
    @ViewBuilder func buildLoadingStateView() -> AnyView {
        AnyView(LoadingView())
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(viewModel: .init())
    }
}
