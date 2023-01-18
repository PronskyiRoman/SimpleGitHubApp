//
//  HomePageListCell.swift
//  GitHubApp
//
//  Created by -_- on 17.01.2023.
//

import SwiftUI

struct HomePageListCell: View, HomePageListCellProtocol {
    // view model
    var viewModel: StateObject<HomePageListCellViewModel>
    
    // init
    init(viewModel: HomePageListCellViewModel) {
        self.viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // body
    var body: some View {
        buildIosBody()
    }
    
    // builders
    @ViewBuilder func buildIosBody() -> some View {
        buildCellBody()
    }
}

struct HomePageListCell_Previews: PreviewProvider {
    static let model = HomePageListCellDataModel(name: "Roman", description: "long Text",
                                                 profileImageUrl: "someURL", language: "Swift")
    static var previews: some View {
        ZStack {
            Color.black
            HomePageListCell(viewModel: .init(model: HomePageListCell_Previews.model))
        }
    }
}
