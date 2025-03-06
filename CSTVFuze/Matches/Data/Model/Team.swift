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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case acronym
        case imageUrl = "image_url"
    }
}

struct Opponent: Codable {
    var type: String?
    var opponent: Team
}
