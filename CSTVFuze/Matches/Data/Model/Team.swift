//
//  Team.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

struct Team: Codable {
    var name: String?
    var imageUrl: String?
    var players: [Player]?
    
    static func placeholder(name: String) -> Team {
        return Team(
            name: name,
            players: [
                .init(
                    id: 1,
                    name: "Nickname",
                    firstName: "Nome",
                    lastName: "Jogador"
                ),
                .init(
                    id: 2,
                    name: "Nickname",
                    firstName: "Nome",
                    lastName: "Jogador"
                ),
                .init(
                    id: 3,
                    name: "Nickname",
                    firstName: "Nome",
                    lastName: "Jogador"
                ),
                .init(
                    id: 4,
                    name: "Nickname",
                    firstName: "Nome",
                    lastName: "Jogador"
                ),
                .init(
                    id: 5,
                    name: "Nickname",
                    firstName: "Nome",
                    lastName: "Jogador"
                ),
            ]
        )
    }
}

struct Opponent: Codable {
    var type: String?
    var opponent: Team
}
