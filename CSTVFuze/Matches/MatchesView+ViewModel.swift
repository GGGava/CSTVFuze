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
    
    func getMatches() async
}

extension MatchesView {
    @Observable
    final class ViewModel<Repository: MatchRepository>: MatchesViewModel {
        var matches: [Match] = []
        var loading = false
        
        let repository: Repository
        
        init(repository: Repository) {
            self.repository = repository
            Task {
                await getMatches()
            }
        }
        
        func getMatches() async {
            loading = true
            matches = try! await repository.getMatchesList()
            loading = false
        }
    }
}
