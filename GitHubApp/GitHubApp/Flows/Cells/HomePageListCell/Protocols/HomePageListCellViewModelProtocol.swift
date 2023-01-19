//
//  HomePageListCellViewModelProtocol.swift
//  GitHubApp
//
//  Created by -_- on 17.01.2023.
//

import SwiftUI
import Combine
import Kingfisher

protocol HomePageListCellViewModelProtocol: ObservableObject {
    var userName: String { get }
    var description: String { get }
    var language: String { get }
    var userImage: Image? { get }
    
    // Constants
    var descriptionTitle: String { get }
    var languageTile: String { get }
    var userImagePlaceholder: Image { get }
    
    // UI
    var titleColor: Color { get }
    var textColor: Color { get }
    var titleFont: Font { get }
    var textFont: Font { get }
    var userNameFont: Font { get }
    var cellBackgroundColor: Color { get }
    var cellShadowColor: Color { get }
    
    // Combine
    var cancellable: Set<AnyCancellable> { get }
    
    func subscribe()
    
    // loading images
    func loadImage(from imageURL: String) async throws -> UIImage
    func cancelLoadingImage(from imageURL: String?)
}

extension HomePageListCellViewModelProtocol {
    func loadImage(from imageURL: String) async throws -> UIImage {
        guard let url = URL(string: imageURL) else {
            preconditionFailure("Incorrect url for downloading Image")
        }
        
        let resource = ImageResource(downloadURL: url)
        return try await withCheckedThrowingContinuation({ continuation in
            KingfisherManager.shared.retrieveImage(with: resource) { result in
                switch result {
                case .success(let value): continuation.resume(returning: value.image)
                case .failure(let error): continuation.resume(throwing: error)
                }
            }
        })
    }
    
    func cancelLoadingImage(from imageURL: String?) {
        guard let imageURL else { return }
        guard let url = URL(string: imageURL) else {
            preconditionFailure("Incorrect url for downloading Image")
        }
        
        KingfisherManager.shared.downloader.cancel(url: url)
    }
}


