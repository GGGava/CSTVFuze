//
//  TeamsRepository.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 07/03/2025.
//

protocol MatchStatsRepository {
    func getMatchOpponents(matchId: Int) async throws -> [Team]
}

// TODO: Add tests
struct PandaScoreMatchStatsRepository: MatchStatsRepository {
    @Injected(\.networkHandler) var networkHandler: NetworkHandling
    @Injected(\.jsonHandler) var jsonHandler: JSONHandling
    
    func getMatchOpponents(matchId: Int) async throws -> [Team] {
        let endpoint = GetOpponentsEndpoint(matchId: matchId)
        let data = try await networkHandler.request(endpoint)
        let opponents = try jsonHandler.from(GetOpponentsEndpoint.Opponents.self, data: data)
        return opponents.opponents
    }
}
