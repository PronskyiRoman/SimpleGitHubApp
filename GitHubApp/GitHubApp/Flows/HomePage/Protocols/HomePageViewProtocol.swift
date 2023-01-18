//
//  HomePageViewProtocol.swift
//  GitHubApp
//
//  Created by -_- on 17.01.2023.
//

import SwiftUI

protocol HomePageViewProtocol {
    associatedtype ViewModel: HomePageViewModelProtocol
    var viewModel: StateObject<ViewModel> { get }
    
    func buildList() -> AnyView
    func buildCell(for item: HomePageListCellDataModel) -> AnyView
    func buildEmptyResponceView() -> AnyView
    func buildLoadingStateView() -> AnyView
}

extension HomePageViewProtocol {
    @ViewBuilder func buildList() -> AnyView {
        AnyView(
            ZStack {
                Color.black
                    .ignoresSafeArea()
                if viewModel.wrappedValue.isFirstLoading {
                    buildLoadingStateView()
                } else if !viewModel.wrappedValue.isFirstLoading && viewModel.wrappedValue.data.isEmpty {
                    ScrollView {
                        buildEmptyResponceView()
                    }
                    .refreshable {
                        await viewModel.wrappedValue.preFetchData()
                    }
                } else if !viewModel.wrappedValue.data.isEmpty {
                    List(viewModel.wrappedValue.data, id: \.self) { item in
                        buildCellView(for: item)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 4))
                            .onAppear {
                                viewModel.wrappedValue.fetchNextPageDataIfNeedIt(item)
                            }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.grouped)
                    .refreshable {
                        await viewModel.wrappedValue.fetchData(with: viewModel.wrappedValue.query)
                    }
                }
                   
            }
                .onAppear {
                    viewModel.wrappedValue.preFetchData()
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(ConstantsStrings.homeNavigationTitle)
                .searchable(text: viewModel.wrappedValue.queryBinding, placement: .navigationBarDrawer(displayMode: .always))
                .onSubmit(of: .search) {
                    viewModel.wrappedValue.fetchData(with: viewModel.wrappedValue.query)
                }
        )
    }
    
    @ViewBuilder private func buildCellView(for item: HomePageListCellDataModel) -> some View {
        if let index = viewModel.wrappedValue.data.firstIndex(where: { $0.hashValue == item.hashValue }), index > 8
            && viewModel.wrappedValue.isLoading
            && index == viewModel.wrappedValue.data.count - 1 {
            VStack(spacing: .zero) {
                buildCell(for: item)
                buildBottomLoadingView()
            }
        } else {
            buildCell(for: item)
        }
    }
    
    @ViewBuilder private func buildBottomLoadingView() -> some View {
        HStack {
            ProgressView()
                .tint(ConstantsColors.tint)
                .scaleEffect(1.5)
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
    }
}
