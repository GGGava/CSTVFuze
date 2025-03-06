//
//  League.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

struct League: Codable {
    var id: Int
    var name: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
    }
}
