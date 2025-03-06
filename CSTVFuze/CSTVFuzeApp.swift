//
//  CSTVFuzeApp.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import SwiftUI

@main
struct CSTVFuzeApp: App {
    @State var showSplashScreen = true
    
    var matchesViewModel = MatchesView.ViewModel(
        repository: PandaScoreMatchRepository()
    )

    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreen()
                    .task {
                        try? await Task.sleep(nanoseconds: UInt64(2 * Double(NSEC_PER_SEC)))
                        showSplashScreen = false
                    }
            } else {
                MatchesView(viewModel: matchesViewModel)
            }
        }
    }
}
