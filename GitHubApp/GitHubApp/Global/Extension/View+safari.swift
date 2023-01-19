//
//  View+safari.swift
//  GitHubApp
//
//  Created by -_- on 19.01.2023.
//

import SwiftUI

extension View {
    func safari(url: URL?, isPresented: Binding<Bool>) -> some View {
        modifier(SafariWithAlert(url: url, isPresented: isPresented))
    }
}

struct SafariWithAlert: ViewModifier {
    var url: URL?
    var isPresented: Binding<Bool>
    
    func body(content: Content) -> some View {
        guard let url = url else {
            return AnyView(content.alert(isPresented: isPresented) {
                Alert(title: Text("Error"), message: Text(ConstantsStrings.errorPageMessage), dismissButton: .default(Text("Ok")))
            })
        }
        
        return AnyView(content.fullScreenCover(isPresented: isPresented) {
            SafariView(url: url)
                .ignoresSafeArea()
        })
    }
}

