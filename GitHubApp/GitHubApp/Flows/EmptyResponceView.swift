//
//  EmptyResponceView.swift
//  GitHubApp
//
//  Created by -_- on 18.01.2023.
//

import SwiftUI

struct EmptyResponceView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Text(ConstantsStrings.emptyResultMessage)
                    .multilineTextAlignment(.center)
                    .font(ConstantsFonts.largeText)
                    .bold()
                    .foregroundColor(ConstantsColors.title)
                    .padding()
            }
            .frame(height: UIScreen.main.bounds.height / 1.7)
        }
        .ignoresSafeArea()
    }
}

struct EmptyResponceView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyResponceView()
    }
}
