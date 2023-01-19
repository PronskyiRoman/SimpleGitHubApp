//
//  View+navBar.swift
//  GitHubApp
//
//  Created by -_- on 19.01.2023.
//

import SwiftUI

extension View {
    func navBar(title: String, searchText: Binding<String>, onSubmitOfSearch: @escaping () -> Void) -> some View {
        modifier(SetupNavBar(title: title, searchText: searchText, onSubmitOfSearch: onSubmitOfSearch))
    }
}

private struct SetupNavBar: ViewModifier {
    let title: String
    var searchText: Binding<String>
    var onSubmitOfSearch: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .searchable(text: searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                onSubmitOfSearch()
            }
    }
}

    
