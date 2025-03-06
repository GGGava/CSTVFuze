//
//  Match.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import Foundation

struct Match: Codable, Identifiable {
    enum Status: String, Codable {
        case running
        case notStarted = "not_started"
    }
    
    var id: Int
    var name: String?
    var status: Match.Status?
    var league: League?
    var opponents: [Opponent]?
    var beginAt: String?
    
    var date: Date? {
        guard let beginAt = beginAt else { return nil }
        return ISO8601DateFormatter().date(from: beginAt)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case league
        case opponents
        case beginAt = "begin_at"
    }
}
