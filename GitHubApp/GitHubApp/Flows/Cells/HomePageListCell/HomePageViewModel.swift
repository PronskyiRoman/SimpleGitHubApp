//
//  HomePageViewModel.swift
//  GitHubApp
//
//  Created by -_- on 17.01.2023.
//

import Foundation
import Combine
import SwiftUI

final class HomePageViewModel: ObservableObject, HomePageViewModelProtocol {
    // data
    @Published var data: [HomePageListCellDataModel] = []
    
    // actions
    @Published var isFirstLoading: Bool = true
    @Published var isLoading: Bool = false
    
    // searching
    @Published var query: String = ""
    var queryBinding: Binding<String>
    var loadingPage: Int = 0
    
    // combine
    var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // servises
    var service: RepositoryService = .init()
    
    // init
    init() {
        queryBinding = .constant("")
        subscribe()
    }
    
    func subscribe() {
        $query.sink(receiveValue: { [weak self] item in
            guard let self else { return }
            self.queryBinding = Binding(get: { item }, set: { self.query = $0 })
        }).store(in: &cancellable)
        
        $query.dropFirst()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                self.fetchData(with: value)
            }).store(in: &cancellable)
    }
}
