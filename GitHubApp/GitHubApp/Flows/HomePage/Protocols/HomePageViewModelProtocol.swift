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
    
    // actions
    var isFirstLoading: Bool { get set }
    var isLoading: Bool { get set }
    var loadingPage: Int { get set }
    
    // services
    var service: RepositoryService { get }
    
    // loading
    func preFetchData()
    func fetchNextPageDataIfNeedIt(_ item: HomePageListCellDataModel)
    
    // handling
    func handleSuccess(_ result: RepoDataContainer)
    func handleError(_ error: Error)
    
    // combine
    var cancellable: Set<AnyCancellable> { get }
    
    func subscribe()
}

extension HomePageViewModelProtocol {
    private var searchConstant: String {
        "a"
    }
    
    func handleSuccess(_ result: RepoDataContainer) {
        let items = result.items.map({
            HomePageListCellDataModel(name: $0.owner.login, description: $0.description ?? "", profileImageUrl: $0.owner.avatarUrl, language: $0.language ?? "")
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
    
    func handleError(_ error: Error) {
        isFirstLoading = false
        isLoading = false
        // TODO: Provide Errors
    }
    
    func preFetchData() {
        fetch(query: query.isEmpty ? searchConstant : query, page: 0)
    }
    
    func fetchNextPageDataIfNeedIt(_ item: HomePageListCellDataModel) {
        guard !isLoading else { return }
        
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



