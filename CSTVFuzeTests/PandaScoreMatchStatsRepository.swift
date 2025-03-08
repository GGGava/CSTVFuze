//
//  PandaScoreMatchStatsRepository.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 08/03/2025.
//

import XCTest
@testable import CSTVFuze

class PandaScoreMatchStatsRepositoryTests: XCTestCase {
    let testingSubject = PandaScoreMatchStatsRepository()
    
    override class func setUp() {
        InjectedValues[\.networkHandler] = NetworkHandlerMock()
        InjectedValues[\.jsonHandler] = JsonHandlerMock()
    }

    func testGetMatchesListDataError() async {
        InjectedValues[\.networkHandler] = NetworkHandlerMock()

        do {
            let _ = try await testingSubject.getMatchOpponents(matchId: 1)
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
            let _ = try await testingSubject.getMatchOpponents(matchId: 1)
            XCTFail()
        } catch {
            if let error = try? XCTUnwrap(error as NSError) {
                XCTAssertEqual(error, jsonError)
            }
        }
    }

    func testSuccess() async {
        let expectedTeams = [Team(id: 1), Team(id: 2)]
        
        let networkMock = NetworkHandlerMock(data: Data())

        InjectedValues[\.networkHandler] = networkMock
        InjectedValues[\.jsonHandler] = JsonHandlerMock(
            response: PandaScoreMatchStatsRepository.Opponents(opponents: expectedTeams)
        )
        
        do {
            let response = try await testingSubject.getMatchOpponents(matchId: 123)
            XCTAssertEqual(2, response.count)
            XCTAssertEqual(response.first?.id, 1)
            XCTAssertEqual(response.last?.id, 2)
            XCTAssertEqual(networkMock.matchId, 123)
        } catch {
            XCTFail()
        }
    }
}

fileprivate class NetworkHandlerMock: NetworkHandling {
    var data: Data?
    var matchId: Int?
    
    init(data: Data? = nil) {
        self.data = data
    }

    func request<T>(_ endpoint: T) async throws -> Data where T : Endpoint {
        if let data = data {
            if let url = URL(string: endpoint.url) {
                let pathComponents = url.pathComponents
                    if pathComponents.count > 1 {
                        matchId = Int(pathComponents[pathComponents.count - 2]) ?? 0
                    }
            }
            
            return data
        }
        throw dataError
    }
}

fileprivate struct JsonHandlerMock: JSONHandling {
    var response: PandaScoreMatchStatsRepository.Opponents?
    func from<T>(_ type: T.Type, data: Data) throws -> T where T : Decodable {
        if let response = response {
            return response as! T
        }
        throw jsonError
    }
}
