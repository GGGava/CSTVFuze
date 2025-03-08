//
//  MatchStatsView+ViewModel.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 07/03/2025.
//

import SwiftUI

extension MatchStatsView {
    final class ViewModel: ObservableObject {
        @Injected(\.opponentsRepository) var teamsRepository: MatchStatsRepository

        @Published var teamA: Team?
        @Published var teamB: Team?
        var match: Match
        
        @Published var loading: Bool = false
        @Published var hasError: Bool = false
        
        init(match: Match) {
            self.match = match

            Task {
                await getTeams()
            }
        }
        
        @MainActor
        func getTeams() async {
            loading = true
            hasError = false
            do {
                let teams = try await teamsRepository.getMatchOpponents(matchId: self.match.id)
                self.teamA = teams.first
                self.teamB = teams.last
            } catch {
                print("Error while fetching opponents: \(error)")
                hasError = true
            }
            loading = false
        }
    }
}
