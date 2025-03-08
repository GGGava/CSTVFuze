//
//  MatchesView+ViewModel.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import SwiftUI

extension MatchesListView {
    final class ViewModel: ObservableObject {
        @Injected(\.matchRepository) var repository: MatchListRepository

        @Published var matches: [Match] = []
        @Published var loading = false
        @Published var hasError = false
        
        init() {
            Task {
                await getMatches()
            }
        }
        
        @MainActor
        func getMatches() async {
            loading = true
            hasError = false
            do {
                matches = try await repository.getMatchesList()
            } catch {
                print("Error while fetching list of matches: \(error)")
                hasError = true
            }
            loading = false
        }
    }
}
