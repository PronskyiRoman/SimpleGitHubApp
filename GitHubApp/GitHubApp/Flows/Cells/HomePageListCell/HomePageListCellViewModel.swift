//
//  HomePageListCellViewModel.swift
//  GitHubApp
//
//  Created by -_- on 17.01.2023.
//

import SwiftUI
import Combine

final class HomePageListCellViewModel: ObservableObject, HomePageListCellViewModelProtocol {
    // Data
    var userName: String
    var description: String
    var language: String
    var created: Date?
    var updated: Date?
    @Published var userImage: Image?
    @Published var userImageUrl: String?
    
    // Constants
    var descriptionTitle: String = ConstantsStrings.homePageDescriptionTitle
    var languageTile: String = ConstantsStrings.homePageLanguageTitle
    var userImagePlaceholder: Image = Image(ConstantsImages.cellPlaceholder)
    var dateCreatedTitle: String = ConstantsStrings.createdAt
    var dateUpdatedTitle: String = ConstantsStrings.updatedAt
    
    // UI
    var titleColor: Color = ConstantsColors.title
    var textColor: Color = ConstantsColors.text
    var titleFont: Font = ConstantsFonts.title2
    var textFont: Font = ConstantsFonts.text
    var userNameFont: Font = ConstantsFonts.title
    var cellBackgroundColor: Color = ConstantsColors.cellBg
    var cellShadowColor: Color = ConstantsColors.cellShadow
    
    // combine
    var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // init
    init(model: HomePageListCellDataModel) {
        self.userName = model.name
        self.description = model.description
        self.language = model.language
        self.userImageUrl = model.profileImageUrl
        self.created = model.created
        self.updated = model.updated
        subscribe()
    }
    
    func subscribe() {
        $userImageUrl.sink(receiveValue: { [weak self] url in
            guard self?.userImage == nil else { return }
            guard let self else { return }
            Task { @MainActor [weak self] in
                guard let self, let url = self.userImageUrl else { return }
                let image = try await self.loadImage(from: url)
                self.userImage = Image(uiImage: image)
            }
        }).store(in: &cancellable)
    }
    
    deinit {
        cancelLoadingImage(from: userImageUrl)
    }
}
