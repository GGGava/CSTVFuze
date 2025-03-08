//
//  TeamsRepository.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 07/03/2025.
//

protocol MatchStatsRepository {
    func getMatchOpponents(matchId: Int) async throws -> [Team]
}

struct PandaScoreMatchStatsRepository: MatchStatsRepository {
    @Injected(\.networkHandler) var networkHandler: NetworkHandling
    @Injected(\.jsonHandler) var jsonHandler: JSONHandling
    
    struct Opponents: Codable {
        var opponents: [Team]
    }
    
    func getMatchOpponents(matchId: Int) async throws -> [Team] {
        let endpoint = GetOpponentsEndpoint(matchId: matchId)
        let data = try await networkHandler.request(endpoint)
        let opponents = try jsonHandler.from(Opponents.self, data: data)
        return opponents.opponents
    }
}
