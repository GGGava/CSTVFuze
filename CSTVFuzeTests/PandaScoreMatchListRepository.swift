//
//  PandaScoreMatchRepository.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import XCTest
@testable import CSTVFuze

class PandaScoreMatchListRepositoryTests: XCTestCase {
    let testingSubject = PandaScoreMatchListRepository()
    
    override func tearDown() {
        InjectedValues[\.networkHandler] = NetworkHandler<URLSession>()
        InjectedValues[\.jsonHandler] = JSONHandler()
    }

    func testGetMatchesListDataError() async {
        InjectedValues[\.networkHandler] = NetworkHandlerMock()

        do {
            let _ = try await testingSubject.getMatchesList(page: 1)
            XCTFail()
        } catch {
            if let error = try? XCTUnwrap(error as NSError) {
                XCTAssertEqual(error, dataError)
            }
        }
    }
    
    func testJsonHandlingError() async {
        InjectedValues[\.networkHandler] = NetworkHandlerMock(data: Data())
        InjectedValues[\.jsonHandler] = JsonHandlerMock()

        do {
            let _ = try await testingSubject.getMatchesList(page: 1)
            XCTFail()
        } catch {
            if let error = try? XCTUnwrap(error as NSError) {
                XCTAssertEqual(error, jsonError)
            }
        }
    }

    func testSuccess() async {
        let expectedMatches = [Match(id: 1, name: "TestMatch")]
        InjectedValues[\.networkHandler] = NetworkHandlerMock(data: Data())
        InjectedValues[\.jsonHandler] = JsonHandlerMock(
            response: expectedMatches
        )
        
        do {
            let response = try await testingSubject.getMatchesList(page: 1)
            XCTAssertEqual(1, response.count)
        } catch {
            XCTFail()
        }
    }
}

fileprivate struct NetworkHandlerMock: NetworkHandling {
    var data: Data?
    func request<T>(_ endpoint: T) async throws -> Data where T : Endpoint {
        if let data = data {
            return data
        }
        throw dataError
    }
}

fileprivate struct JsonHandlerMock: JSONHandling {
    var response: [Match]?
    func from<T>(_ type: T.Type, data: Data) throws -> T where T : Decodable {
        if let response = response {
            return response as! T
        }
        throw jsonError
    }
}

let dataError = NSError(domain: "DataError", code: 1)
let jsonError = NSError(domain: "JsonError", code: 2)
