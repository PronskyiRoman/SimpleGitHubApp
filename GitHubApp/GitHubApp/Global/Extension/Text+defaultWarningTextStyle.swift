//
//  Text+defaultWarningTextStyle.swift
//  GitHubApp
//
//  Created by -_- on 19.01.2023.
//

import SwiftUI

extension Text {
    func defaultWarningTextStyle() -> some View {
        modifier(DefaultWarningTextStyle())
    }
}

private struct DefaultWarningTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(ConstantsFonts.largeText)
            .bold()
            .foregroundColor(ConstantsColors.title)
            .padding()
    }
}

