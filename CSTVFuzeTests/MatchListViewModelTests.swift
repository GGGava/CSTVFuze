//
//  MatchesListView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 08/03/2025.
//

import XCTest
@testable import CSTVFuze

class MatchListViewModelTests: XCTestCase {
    func testGetMatchListError() async {
        InjectedValues[\.matchListRepository] = MatchListRepositoryMock()

        let testingSubject = MatchListViewModel(fetchData: false)
        await testingSubject.getMatches()

        XCTAssertEqual(testingSubject.matches.count, 0)
        XCTAssertFalse(testingSubject.loading)
        XCTAssertTrue(testingSubject.hasError)
        XCTAssertEqual(testingSubject.nextPage, 1)
        XCTAssertFalse(testingSubject.loadingNextPage)
        XCTAssertFalse(testingSubject.finishedPages)
    }

    func testGetMatchListSuccessEmpty() async {
        let expectedResult: [Match] = []
        InjectedValues[\.matchListRepository] = MatchListRepositoryMock(data: expectedResult)

        let testingSubject = MatchListViewModel(fetchData: false)
        await testingSubject.getMatches()

        XCTAssertEqual(testingSubject.matches.count, expectedResult.count)
        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.nextPage, 2)
        XCTAssertFalse(testingSubject.loadingNextPage)
        XCTAssertFalse(testingSubject.finishedPages)
    }

    func testGetMatchListSuccess() async {
        let expectedResult: [Match] = [
            .init(id: 1)
        ]
        InjectedValues[\.matchListRepository] = MatchListRepositoryMock(data: expectedResult)

        let testingSubject = MatchListViewModel(fetchData: false)
        await testingSubject.getMatches()

        XCTAssertEqual(testingSubject.matches.count, expectedResult.count)
        XCTAssertEqual(testingSubject.matches.first?.id, expectedResult.first?.id)
        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.nextPage, 2)
        XCTAssertFalse(testingSubject.loadingNextPage)
        XCTAssertFalse(testingSubject.finishedPages)
    }

    func testLoadMoreError() async {
        InjectedValues[\.matchListRepository] = MatchListRepositoryMock()

        let testingSubject = MatchListViewModel(fetchData: false)
        await testingSubject.loadMore()

        XCTAssertEqual(testingSubject.matches.count, 0)
        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.nextPage, 1)
        XCTAssertFalse(testingSubject.loadingNextPage)
        XCTAssertFalse(testingSubject.finishedPages)
    }

    func testLoadMoreSuccessEmpty() async {
        InjectedValues[\.matchListRepository] = MatchListRepositoryMock(
            data: []
        )

        let testingSubject = MatchListViewModel(fetchData: false)
        await testingSubject.loadMore()

        XCTAssertEqual(testingSubject.matches.count, 0)
        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.nextPage, 1)
        XCTAssertFalse(testingSubject.loadingNextPage)
        XCTAssertTrue(testingSubject.finishedPages)
    }

    func testLoadMoreSuccessAppendingAndFinished() async {
        let mock = MatchListRepositoryMock(
            data: [.init(id: 2)]
        )
        InjectedValues[\.matchListRepository] = mock

        let testingSubject = MatchListViewModel(fetchData: false)
        testingSubject.matches = [.init(id: 1)]
        await testingSubject.loadMore()

        XCTAssertEqual(testingSubject.matches.count, 2)
        XCTAssertEqual(testingSubject.matches.first?.id, 1)
        XCTAssertEqual(testingSubject.matches.last?.id, 2)
        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.nextPage, 1)
        XCTAssertFalse(testingSubject.loadingNextPage)
        XCTAssertTrue(testingSubject.finishedPages)
        XCTAssertEqual(mock.page, 1)
    }

    func testLoadMoreSuccessAppendingNotFinished() async {
        var matches: [Match] = []
        for i in 2...11 {
            matches.append(.init(id: i))
        }
        let mock = MatchListRepositoryMock(
            data: matches
        )
        InjectedValues[\.matchListRepository] = mock

        let testingSubject = MatchListViewModel(fetchData: false)
        testingSubject.matches = [.init(id: 1)]
        await testingSubject.loadMore()

        XCTAssertEqual(testingSubject.matches.count, 11)
        XCTAssertEqual(testingSubject.matches.first?.id, 1)
        XCTAssertEqual(testingSubject.matches.last?.id, 11)
        XCTAssertFalse(testingSubject.loading)
        XCTAssertFalse(testingSubject.hasError)
        XCTAssertEqual(testingSubject.nextPage, 2)
        XCTAssertFalse(testingSubject.loadingNextPage)
        XCTAssertFalse(testingSubject.finishedPages)
        XCTAssertEqual(mock.page, 1)
    }
}

fileprivate class MatchListRepositoryMock: MatchListRepository {
    var data: [CSTVFuze.Match]?
    var page = 0

    init(data: [CSTVFuze.Match]? = nil) {
        self.data = data
    }

    func getMatchesList(page: Int) async throws -> [CSTVFuze.Match] {
        self.page = page
        if let data = data {
            return data
        }
        throw NSError(domain: "ErrorTest", code: 1)
    }
}
