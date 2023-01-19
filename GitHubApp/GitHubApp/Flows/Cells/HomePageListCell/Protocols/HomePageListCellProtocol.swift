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
                buildDate()
            }
            .padding(.horizontal)
            Spacer()
        }
            .background(viewModel.wrappedValue.cellBackgroundColor)
            .cornerRadius(8)
            .shadow(color: viewModel.wrappedValue.cellShadowColor, radius: 3.5)
            .padding(.horizontal, 6))
    }
    
    @ViewBuilder private func buildUserLabel() -> AnyView {
        AnyView(HStack(alignment: .bottom, spacing: 8) {
            ZStack {
                if viewModel.wrappedValue.userImage == nil {
                    viewModel.wrappedValue.userImagePlaceholder
                        .resizable(resizingMode: .stretch)
                        .frame(width: 25, height: 25)
                } else {
                    viewModel.wrappedValue.userImage?
                        .resizable(resizingMode: .stretch)
                        .frame(width: 25, height: 25)
                }
            }
            .clipShape(Circle())
            
            Text(viewModel.wrappedValue.userName)
                .foregroundColor(viewModel.wrappedValue.textColor)
                .font(viewModel.wrappedValue.userNameFont)
                .lineLimit(1)
        }
            .padding(.top, 10))
    }
    
    @ViewBuilder private func buildRepoDescription() -> AnyView {
        AnyView(VStack(alignment: .leading, spacing: .zero) {
            if !viewModel.wrappedValue.description.isEmpty {
                Text(viewModel.wrappedValue.descriptionTitle)
                    .foregroundColor(viewModel.wrappedValue.titleColor)
                    .font(viewModel.wrappedValue.titleFont)
                
                Text(viewModel.wrappedValue.description)
                    .foregroundColor(viewModel.wrappedValue.textColor)
                    .font(viewModel.wrappedValue.textFont)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        })
    }
    
    @ViewBuilder private func buildRepoLanguageLabel() -> AnyView {
        AnyView(HStack(alignment: .bottom, spacing: 6) {
            if !viewModel.wrappedValue.language.isEmpty {
                Text(viewModel.wrappedValue.languageTile)
                    .foregroundColor(viewModel.wrappedValue.titleColor)
                    .font(viewModel.wrappedValue.titleFont)
                
                Text(viewModel.wrappedValue.language)
                    .foregroundColor(viewModel.wrappedValue.textColor)
                    .font(viewModel.wrappedValue.textFont)
                    .bold()
                    .padding(.bottom, 1)
            }
        }
            .lineLimit(1))
    }
    
    @ViewBuilder private func buildDateLabel(_ isCreated: Bool, text: String) -> some View  {
        HStack(alignment: .bottom, spacing: 6) {
            Text(isCreated ? viewModel.wrappedValue.dateCreatedTitle : viewModel.wrappedValue.dateUpdatedTitle)
                .foregroundColor(viewModel.wrappedValue.titleColor)
                .font(viewModel.wrappedValue.textFont)
                .bold()
            
            Text(text)
                .foregroundColor(viewModel.wrappedValue.textColor)
                .font(viewModel.wrappedValue.textFont)
        }
        .lineLimit(1)
    }
    
    @ViewBuilder private func buildDate() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            if let created = viewModel.wrappedValue.created?.iosFullString {
                buildDateLabel(true, text: created)
            }
            
            if let updated = viewModel.wrappedValue.updated?.iosFullString {
                buildDateLabel(false, text: updated)
            }
        }
        .padding(.bottom, 10)
    }
}
