//
//  ErrorPage.swift
//  GitHubApp
//
//  Created by -_- on 18.01.2023.
//

import SwiftUI

struct ErrorPage: View {
    var body: some View {
        ZStack {
            Text(ConstantsStrings.errorPageMessage)
                .defaultWarningTextStyle()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ErrorPage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorPage()
    }
}
