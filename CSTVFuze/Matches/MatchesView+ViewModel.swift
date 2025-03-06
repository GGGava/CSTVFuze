//
//  MatchesView+ViewModel.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import SwiftUI

protocol MatchesViewModel {
    var matches: [Match] { get }
    var loading: Bool { get }
    var hasError: Bool { get }
    
    func getMatches() async
}

extension MatchesView {
    @Observable
    final class ViewModel<Repository: MatchRepository>: MatchesViewModel {
        var matches: [Match] = []
        var loading = false
        var hasError = false
        
        let repository: Repository
        
        init(repository: Repository) {
            self.repository = repository
            Task {
                await getMatches()
            }
        }
        
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
