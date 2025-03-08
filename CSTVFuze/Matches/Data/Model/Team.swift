//
//  Team.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

struct Team: Codable {
    var id: Int
    var name: String?
    var acronym: String?
    var imageUrl: String?
    var players: [Player]?
}

struct Opponent: Codable {
    var type: String?
    var opponent: Team
}
