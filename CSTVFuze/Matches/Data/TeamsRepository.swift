//
//  TeamsRepository.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 07/03/2025.
//

protocol TeamsRepository {
    func getTeam(id: Int) async throws -> Team
}

struct PandaScoreTeamsRepository: TeamsRepository {
    @Injected(\.networkHandler) var networkHandler: NetworkHandling
    @Injected(\.jsonHandler) var jsonHandler: JSONHandling

    func getTeam(id: Int) async throws -> Team {
        let endpoint = GetTeamEndpoint(team: id)
        let data = try await networkHandler.request(endpoint)
        return try jsonHandler.from(Team.self, data: data)
    }
}
