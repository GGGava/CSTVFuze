//
//  JSONDataDecoder.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import Foundation

protocol JSONHandling {
    func from<T: Decodable>(_ type: T.Type, data: Data) throws -> T
}

final class JSONHandler: JSONHandling {
    func from<T>(_ type: T.Type, data: Data) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(type, from: data)
    }
}
