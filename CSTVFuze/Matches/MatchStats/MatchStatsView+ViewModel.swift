//
//  MatchStatsView+ViewModel.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 07/03/2025.
//

import SwiftUI

extension MatchStatsView {
    final class ViewModel: ObservableObject {
        @Injected(\.teamsRepository) var teamsRepository: TeamsRepository

        @Published var teamA: Team?
        @Published var teamB: Team?
        
        var matchStatus: Match.Status?
        var matchTime: Date?
        
        @Published var loading: Bool = false
        @Published var hasError: Bool = false
        
        var matchId: Int
        
        init(match: Match) {
            self.matchStatus = match.status
            self.matchTime = match.date
            self.matchId = match.id

            Task {
                await getTeams()
            }
        }
        
        @MainActor
        func getTeams() async {
            loading = true
            hasError = false
            do {
                let teams = try await teamsRepository.getMatchOpponents(matchId: self.matchId)
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
