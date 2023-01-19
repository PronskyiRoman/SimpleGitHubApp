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
    var coordinator: Coordinator { get }
    
    func buildList() -> AnyView
    func buildCell(for item: HomePageListCellDataModel) -> AnyView
    func buildEmptyResponceView() -> AnyView
    func buildLoadingStateView() -> AnyView
}

extension HomePageViewProtocol {
    @ViewBuilder func buildList() -> AnyView {
        AnyView(
            ZStack {
                ConstantsColors.appBg
                    .ignoresSafeArea()
                if viewModel.wrappedValue.isFirstLoading {
                    buildLoadingStateView()
                } else if !viewModel.wrappedValue.isFirstLoading && viewModel.wrappedValue.data.isEmpty {
                    ScrollView {
                        buildEmptyResponceView()
                    }
                    .refreshable {
                        await viewModel.wrappedValue.onPullToRefreshGesture()
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
                            .onTapGesture {
                                viewModel.wrappedValue.onCellTapGesture(coordinator, item: item)
                            }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.grouped)
                    .refreshable {
                        await viewModel.wrappedValue.onPullToRefreshGesture()
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
                .safari(url: viewModel.wrappedValue.safariUrl, isPresented: viewModel.wrappedValue.isSafariPresentedBinding)
        )
    }
    
    @ViewBuilder private func buildCellView(for item: HomePageListCellDataModel) -> some View {
        if viewModel.wrappedValue.allowBottomLoadingView(for: item) {
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
