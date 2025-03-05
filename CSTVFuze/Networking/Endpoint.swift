//
//  Endpoint.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

protocol Endpoint {
    var url: String { get }
    var method: HTTPMethod { get }
    var params: [String: String] { get }
    var token: String? { get }
}

enum HTTPMethod: String {
    case get = "GET"
}
