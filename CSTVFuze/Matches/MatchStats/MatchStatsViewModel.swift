//
//  MatchStatsViewModel.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 07/03/2025.
//

import SwiftUI

final class MatchStatsViewModel: ObservableObject {
    @Injected(\.matchStatsRepository) var teamsRepository: MatchStatsRepository

    @Published var teamA: Team?
    @Published var teamB: Team?
    var match: Match
    
    @Published var loading: Bool = false
    @Published var hasError: Bool = false
    
    init(match: Match, fetchData: Bool = true) {
        self.match = match

        if fetchData {
            Task {
                await getTeams()
            }
        }
    }
    
    @MainActor
    func getTeams() async {
        loading = true
        hasError = false
        do {
            let teams = try await teamsRepository.getMatchOpponents(matchId: self.match.id)
            self.teamA = teams.first ?? Team.placeholder(name: "Time 1")
            self.teamB = teams.indices.contains(1) ? teams[1] : Team.placeholder(name: "Time 2")
        } catch {
            print("Error while fetching opponents: \(error)")
            hasError = true
        }
        loading = false
    }
}
