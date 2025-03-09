//
//  MatchStatsViewModelTests.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 08/03/2025.
//

import XCTest
@testable import CSTVFuze

class MatchStatsViewModelTests: XCTestCase {
    func testGetTeamsError() async {
        InjectedValues[\.matchStatsRepository] = MatchStatsRepositoryMock()
        
        let testingSubject = MatchStatsViewModel(match: .init(id: 1), fetchData: false)
        await testingSubject.getTeams()

        XCTAssertFalse(testingSubject.loading)
        XCTAssertTrue(testingSubject.hasError)
        XCTAssertNil(testingSubject.teamA)
        XCTAssertNil(testingSubject.teamB)
    }
    
    func testGetTeamsSuccessEmpty() async {
        let mock = MatchStatsRepositoryMock(
            data: []
        )
        InjectedValues[\.matchStatsRepository] = mock
        
        let testingSubject = MatchStatsViewModel(match: .init(id: 1), fetchData: false)
        await testingSubject.getTeams()

        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.teamA?.name, "Time 1")
        XCTAssertEqual(testingSubject.teamB?.name, "Time 2")
        XCTAssertEqual(mock.matchId, 1)
    }

    func testGetTeamsSuccessTeamAOnly() async {
        let expectedResult: Team = .init(name: "ExpectedTeam")
        let mock = MatchStatsRepositoryMock(
            data: [
                expectedResult
            ]
        )
        InjectedValues[\.matchStatsRepository] = mock
        
        let testingSubject = MatchStatsViewModel(match: .init(id: 1), fetchData: false)
        await testingSubject.getTeams()

        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.teamA?.name, expectedResult.name)
        XCTAssertEqual(testingSubject.teamB?.name, "Time 2")
        XCTAssertEqual(mock.matchId, 1)
    }

    func testGetTeamsSuccessBothTeams() async {
        let expectedResult: [Team] = [
            .init(name: "ExpectedTeamA"),
            .init(name: "ExpectedTeamB")
        ]
        let mock = MatchStatsRepositoryMock(
            data: expectedResult
        )
        InjectedValues[\.matchStatsRepository] = mock
        
        let testingSubject = MatchStatsViewModel(match: .init(id: 1), fetchData: false)
        await testingSubject.getTeams()

        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.teamA?.name, expectedResult[0].name)
        XCTAssertEqual(testingSubject.teamB?.name, expectedResult[1].name)
        XCTAssertEqual(mock.matchId, 1)
    }
}

fileprivate class MatchStatsRepositoryMock: MatchStatsRepository {
    var data: [CSTVFuze.Team]?
    var matchId: Int?
    
    init(data: [CSTVFuze.Team]? = nil) {
        self.data = data
    }

    func getMatchOpponents(matchId: Int) async throws -> [CSTVFuze.Team] {
        if let data = data {
            self.matchId = matchId
            return data
        }
        throw NSError(domain: "ErrorTest", code: 1)
    }
}
