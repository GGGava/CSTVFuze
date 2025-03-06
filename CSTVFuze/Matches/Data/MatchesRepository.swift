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
        // TODO: Get finished matches today. Possibly move parameters out of the repository.
        let endpoint = GetMatchesEndpoint(
            params: [
                "filter[status]":"running,not_started",
                "sort":"begin_at"
            ]
        )
        let data = try await networkHandler.request(endpoint)
        return try jsonHandler.from([Match].self, data: data)
    }
}
