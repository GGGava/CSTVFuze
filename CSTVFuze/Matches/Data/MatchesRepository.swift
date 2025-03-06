//
//  MatchesRepository.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

protocol MatchRepository {
    func getMatchesList() async throws -> [Match]
}

struct PandaScoreMatchRepository: MatchRepository {
    @Injected(\.networkHandler) var networkHandler: NetworkHandling
    @Injected(\.jsonHandler) var jsonHandler: JSONHandling

    func getMatchesList() async throws -> [Match] {
        let endpoint = GetMatchesEndpoint(params: [:])
        let data = try await networkHandler.request(endpoint)
        return try jsonHandler.from([Match].self, data: data)
    }
}
