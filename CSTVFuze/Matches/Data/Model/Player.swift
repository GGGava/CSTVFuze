//
//  Player.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 07/03/2025.
//

struct Player: Codable, Identifiable {
    var id: Int
    var name: String?
    var firstName: String?
    var lastName: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case imageUrl = "image_url"
    }
}
