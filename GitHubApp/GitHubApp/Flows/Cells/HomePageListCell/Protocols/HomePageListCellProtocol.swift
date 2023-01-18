//
//  HomePageListCellProtocol.swift
//  GitHubApp
//
//  Created by -_- on 17.01.2023.
//

import SwiftUI

protocol HomePageListCellProtocol {
    associatedtype ViewModel: HomePageListCellViewModelProtocol
    var viewModel: StateObject<ViewModel> { get set }
    
    func buildCellBody() -> AnyView
}

extension HomePageListCellProtocol {
    @ViewBuilder func buildCellBody() -> AnyView {
        AnyView(HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: 5) {
                buildUserLabel()
                buildRepoDescription()
                buildRepoLanguageLabel()
                Spacer()
            }
            .frame(height: 95)
            Spacer()
        }
            .background(viewModel.wrappedValue.cellBackgroundColor)
            .cornerRadius(8)
            .shadow(color: viewModel.wrappedValue.cellShadowColor, radius: 5)
            .padding(.horizontal, 6))
    }
    
    @ViewBuilder private func buildUserLabel() -> AnyView {
        AnyView(HStack(alignment: .bottom, spacing: .zero) {
            ZStack {
                if viewModel.wrappedValue.userImage == nil {
                    viewModel.wrappedValue.userImagePlaceholder
                } else {
                    viewModel.wrappedValue.userImage
                }
            }
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 4, trailing: 8))
            Text(viewModel.wrappedValue.userName)
                .foregroundColor(viewModel.wrappedValue.textColor)
                .font(viewModel.wrappedValue.userNameFont)
                .padding(.trailing)
        })
    }
    
    @ViewBuilder private func buildRepoDescription() -> AnyView {
        AnyView(VStack(alignment: .leading, spacing: .zero) {
            Text(viewModel.wrappedValue.descriptionTitle)
                .foregroundColor(viewModel.wrappedValue.titleColor)
                .font(viewModel.wrappedValue.titleFont)
            
            Text(viewModel.wrappedValue.description)
                .foregroundColor(viewModel.wrappedValue.textColor)
                .font(viewModel.wrappedValue.textFont)
        }
            .padding(.horizontal)
            .lineLimit(2))
    }
    
    @ViewBuilder private func buildRepoLanguageLabel() -> AnyView {
        AnyView(HStack(spacing: 6) {
            Text(viewModel.wrappedValue.languageTile)
                .foregroundColor(viewModel.wrappedValue.titleColor)
                .font(viewModel.wrappedValue.titleFont)
            
            Text(viewModel.wrappedValue.language)
                .foregroundColor(viewModel.wrappedValue.textColor)
                .font(viewModel.wrappedValue.textFont)
        }
            .font(.caption)
            .padding(.horizontal)
            .lineLimit(1))
    }
}
