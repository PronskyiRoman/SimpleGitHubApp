//
//  LoadingView.swift
//  GitHubApp
//
//  Created by -_- on 18.01.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .scaleEffect(2.5)
                .tint(ConstantsColors.tint)
        }
        .ignoresSafeArea()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
