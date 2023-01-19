//
//  HomePageViewModelProtocol.swift
//  GitHubApp
//
//  Created by -_- on 17.01.2023.
//

import Foundation
import Combine
import SwiftUI

protocol HomePageViewModelProtocol: ObservableObject {
    // data
    var data: [HomePageListCellDataModel] { get set }
    var query: String { get }
    var queryBinding: Binding<String> { get set }
    var safariUrl: URL? { get set }
    
    // actions
    var isFirstLoading: Bool { get set }
    var isLoading: Bool { get set }
    var loadingPage: Int { get set }
    var isSafariPresented: Bool { get set }
    var isSafariPresentedBinding: Binding<Bool> { get set }
    
    // services
    var service: RepositoryService { get }
    
    // loading
    func preFetchData()
    func fetchData(with query: String)
    func fetchNextPageDataIfNeedIt(_ item: HomePageListCellDataModel)
    func onPullToRefreshGesture()
    
    // combine
    var cancellable: Set<AnyCancellable> { get }
    
    func subscribe()
    
    // func
    func onCellTapGesture(_ coordinator: Coordinator, item: HomePageListCellDataModel)
    func allowBottomLoadingView(for item: HomePageListCellDataModel) -> Bool
    
    // safari
    func onDismissSafari()
}

// MARK: fetch data
extension HomePageViewModelProtocol {
    private var searchConstant: String {
        "a"
    }
    
    private func handleSuccess(_ result: RepoDataContainer) {
        let items = result.items.map({
            HomePageListCellDataModel(name: $0.owner.login, description: $0.description ?? "",
                                      profileImageUrl: $0.owner.avatarUrl, language: $0.language ?? "",
                                      repoUrl: $0.gitUrl, created: $0.createdAt.iosFullDate, updated: $0.updatedAt.iosFullDate)
        })
        
        items.forEach({ item in
            if !data.contains(where: { $0.hashValue == item.hashValue }) {
                data.append(item)
            }
        })
        
        isFirstLoading = false
        isLoading = false
        loadingPage += 1
    }
    
    private func handleError(_ error: Error) {
        isFirstLoading = false
        isLoading = false
        // TODO: Provide Errors
    }
    
    func preFetchData() {
        guard isFirstLoading else { return }
        fetch(query: query.isEmpty ? searchConstant : query, page: 0)
    }
    
    func fetchNextPageDataIfNeedIt(_ item: HomePageListCellDataModel) {
        let lastIndex = data.index(data.endIndex, offsetBy: -10)
        if data.firstIndex(where: { $0.hashValue == item.hashValue }) == lastIndex, lastIndex > 7 {
            isLoading = true
            fetch(query: query.isEmpty ? searchConstant : query, page: loadingPage)
        }
    }
    
    func fetchData(with query: String) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            self.isFirstLoading = true
            self.loadingPage = 0
            self.data.removeAll()
            self.fetch(query: query.isEmpty ? searchConstant : query, page: 0)
        }
    }
    
    private func fetch(query: String, page: Int) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let result = try await service.getRepoDataContainer(for: query, and: page)
                self.handleSuccess(result)
            } catch {
                self.handleError(error)
            }
        }
    }
}

// MARK: Safari
extension HomePageViewModelProtocol {
    private func repoUrl(_ item: HomePageListCellDataModel) -> URL? {
        guard let first = data.first(where: { $0.hashValue == item.hashValue }),
              let url = URL(string: first.repoUrl) else { return nil }
        
        return url
    }
    
    private func presentSafari(for url: URL) {
        self.safariUrl = url
        self.isSafariPresented = true
    }
    
    func onDismissSafari() {
        self.safariUrl = nil
    }
}

// MARK: Gestures
extension HomePageViewModelProtocol {
    func onCellTapGesture(_ coordinator: Coordinator, item: HomePageListCellDataModel) {
        if let url = repoUrl(item) {
            presentSafari(for: url)
        } else {
            coordinator.push(.errorPage)
        }
    }
    
    func onPullToRefreshGesture() {
        fetchData(with: query)
    }
}

// MARK: some rules
extension HomePageViewModelProtocol {
    func allowBottomLoadingView(for item: HomePageListCellDataModel) -> Bool {
        guard let index = data.firstIndex(where: { $0.hashValue == item.hashValue }),
              index > 8,
              index == data.count - 1,
              isLoading
        else { return false }
       
        return true
    }
}

