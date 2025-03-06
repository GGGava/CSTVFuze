//
//  SplashScreen.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Image(.fuzeLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray900)
    }
}

#Preview {
    SplashScreen()
}
