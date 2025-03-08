//
//  MatchesRepository.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

protocol MatchListRepository {
    func getMatchesList() async throws -> [Match]
}

struct PandaScoreMatchListRepository: MatchListRepository {
    @Injected(\.networkHandler) var networkHandler: NetworkHandling
    @Injected(\.jsonHandler) var jsonHandler: JSONHandling

    func getMatchesList() async throws -> [Match] {
        // TODO: Get finished matches today. Possibly move parameters out of the repository.
        let endpoint = GetMatchesEndpoint(
            params: [
                "filter[status]":"running,not_started",
                "sort":"-status,begin_at"
            ]
        )
        let data = try await networkHandler.request(endpoint)
        return try jsonHandler.from([Match].self, data: data)
    }
}
