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
        
        var idTeamA: Int
        var idTeamB: Int

        @Published var teamA: Team?
        @Published var teamB: Team?
        
        var matchStatus: Match.Status?
        var matchTime: Date?
        
        @Published var loading: Bool = false
        @Published var hasError: Bool = false
        
        init(match: Match) {
            self.idTeamA =  match.opponents?.first?.opponent.id ?? 0
            self.idTeamB = match.opponents?.last?.opponent.id ?? 0
            self.matchStatus = match.status
            self.matchTime = match.date

            Task {
                await getTeams(idA: idTeamA, idB: idTeamB)
            }
        }
        
        @MainActor
        func getTeams(idA: Int, idB: Int) async {
            loading = true
            hasError = false
            do {
                async let teamA = teamsRepository.getTeam(id: idA)
                async let teamB = teamsRepository.getTeam(id: idB)
                self.teamA = try await teamA
                self.teamB = try await teamB
            } catch {
                hasError = true
            }
            loading = false
        }
    }
}
