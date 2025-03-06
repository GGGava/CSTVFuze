//
//  MatchesView+ViewModel.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import SwiftUI

extension MatchesView {
    @Observable
    final class ViewModel<Repository: MatchRepository> {
        var matches: [Match] = []
        
        let repository: Repository
        
        init(repository: Repository) {
            self.repository = repository
        }
        
        func getMatches() async {
            matches = try! await repository.getMatchesList()
        }
    }
}
