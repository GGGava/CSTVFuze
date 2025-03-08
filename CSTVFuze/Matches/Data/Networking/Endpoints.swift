//
//  Endpoints.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import Foundation

final class GetMatchesEndpoint: PandaScoreEndpoint {
    init(params: [String: String]) {
        super.init(
            url: "csgo/matches",
            method: .get,
            params: params
        )
    }
}

final class GetTeamEndpoint: PandaScoreEndpoint {
    init(team: Int) {
        super.init(
            url: "teams/" + "\(team)",
            method: .get,
            params: [:]
        )
    }
}

final class GetOpponentsEndpoint: PandaScoreEndpoint {
    //TODO: Make this standart
    struct Opponents: Codable {
        var opponents: [Team]
    }

    init(matchId: Int) {
        super.init(
            url: "matches/" + "\(matchId)/opponents",
            method: .get,
            params: [:]
        )
    }
}

class PandaScoreEndpoint: Endpoint {
    var token: String?
    var url: String
    var method: HTTPMethod
    var params: [String : String]
    
    init(url: String, method: HTTPMethod, params: [String : String]) {
        self.url = "https://api.pandascore.co/" + url
        self.method = method
        self.params = params
        
        if let apiKey = ProcessInfo.processInfo.environment["PANDA_API_KEY"] {
            self.token = apiKey
        }
    }
}
