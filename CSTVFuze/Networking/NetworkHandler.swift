//
//  NetworkHandler.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import Foundation

protocol NetworkHandling {
    func request<T: Endpoint>(_ endpoint: T) async throws -> Data
}

final class NetworkHandler<Session: NetworkSession>: NetworkHandling {
    func request<T: Endpoint>(_ endpoint: T) async throws -> Data {
        let url = try createUrl(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        if let token = endpoint.token {
            request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await performDataRequest(for: request)
            
        guard let response = response as? HTTPURLResponse else {
            print("Error: Network Handler could not parse HTTP response")
            throw Self.Error(.invalidResponse)
        }
        
        guard (200...299).contains(response.statusCode) else {
            print("Error: Network data request returned \(response.statusCode)")
            throw Self.Error(.statusCodeError)
        }
        
        return data
    }

    private func createUrl<T: Endpoint>(_ endpoint: T) throws -> URL {
        guard let url = URL(string: endpoint.url) else {
            print("Error: Network Handler unable to create URL")
            throw Self.Error(.urlError)
        }
        
        if endpoint.params.keys.isEmpty {
            return url
        }
        
        let queryParams = endpoint.params.keys.map { key in
            URLQueryItem(name: key, value: endpoint.params[key])
        }
        
        return url.appending(queryItems: queryParams)
    }
    
    private func performDataRequest(for request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await Session.data(for: request)
        } catch {
            throw NetworkHandler.Error(.sessionError, underlying: error)
        }
    }
}

extension NetworkHandler {
    struct Error: Swift.Error {
        enum Code {
            case urlError
            case statusCodeError
            case invalidResponse
            case sessionError
        }
    
        let code: Self.Code
        let underlying: Swift.Error?
    
        init(
            _ code: Self.Code,
            underlying: Swift.Error? = nil
        ) {
            self.code = code
            self.underlying = underlying
        }
    }
}
