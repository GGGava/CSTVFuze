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
    var serie: Serie?
    var beginAt: Date?
}
