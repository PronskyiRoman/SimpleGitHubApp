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
        AnyView(ZStack {
            // background
            buildBackgroundView()
            
            // screen state
            if viewModel.wrappedValue.isFirstLoading {
                buildLoadingStateView()
            } else if !viewModel.wrappedValue.isFirstLoading && viewModel.wrappedValue.data.isEmpty {
                buildEmptyView()
            } else if !viewModel.wrappedValue.data.isEmpty {
                buildFilledListView()
            }
        }
            .onAppear {
                viewModel.wrappedValue.preFetchData()
            }
                // navigation bar
            .navBar(title: ConstantsStrings.homeNavigationTitle,
                    searchText: viewModel.wrappedValue.queryBinding,
                    onSubmitOfSearch: { viewModel.wrappedValue.fetchData(with: viewModel.wrappedValue.query) })
                // safari view
            .safari(url: viewModel.wrappedValue.safariUrl, isPresented: viewModel.wrappedValue.isSafariPresentedBinding))
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
    
    @ViewBuilder private func buildEmptyView() -> some View {
        ScrollView {
            buildEmptyResponceView()
        }
        .refreshable {
            await viewModel.wrappedValue.onPullToRefreshGesture()
        }
    }
    
    @ViewBuilder private func buildFilledListView() -> some View {
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
    
    @ViewBuilder private func buildBackgroundView() -> some View {
        ConstantsColors.appBg
            .ignoresSafeArea()
    }
}
