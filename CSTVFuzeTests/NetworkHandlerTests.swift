//
//  NetworkHandlerTests.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import XCTest
@testable import CSTVFuze

class NetworkHandlerTests: XCTestCase {
    typealias TestingNetworkHandler = NetworkHandler<MockedNetworkSession>
    
    struct TestEndpoint: Endpoint {
        var url: String
        var method: HTTPMethod
        var params: [String : String]
        var token: String?
    }
    
    override func tearDown() {
        MockedNetworkSession.returnData = nil
        MockedNetworkSession.response = nil
    }

    func testUrlError() async {
        let testingSubject = TestingNetworkHandler()
        
        do {
            let _ = try await testingSubject.request(TestEndpoint(url: "", method: .get, params: [:]))
            XCTFail()
        } catch {
            guard let error = try? XCTUnwrap(error as? TestingNetworkHandler.Error) else {
                XCTFail()
                return
            }
            XCTAssertEqual(error.code, .urlError)
            XCTAssertNil(error.underlying)
        }
    }
    
    func testSessionError() async {
        let testingSubject = TestingNetworkHandler()
        
        do {
            let _ = try await testingSubject.request(TestEndpoint(url: "google.com", method: .get, params: [:]))
            XCTFail()
        } catch {
            guard let error = try? XCTUnwrap(error as? TestingNetworkHandler.Error) else {
                XCTFail()
                return
            }
            XCTAssertEqual(error.code, .sessionError)
            if let underlying = try? XCTUnwrap(error.underlying as NSError?) {
                XCTAssertIdentical(
                    underlying,
                    MockedNetworkSession.error
                )
            }
        }
    }
    
    func testStatusCodeError() async {
        let testingSubject = TestingNetworkHandler()
        MockedNetworkSession.returnData = Data()
        MockedNetworkSession.response = HTTPURLResponse(
            url: URL(string: "google.com")!,
            statusCode: 400,
            httpVersion: "HTTP/1.1",
            headerFields: nil
        )
        
        do {
            let _ = try await testingSubject.request(TestEndpoint(url: "google.com", method: .get, params: [:]))
            XCTFail()
        } catch {
            guard let error = try? XCTUnwrap(error as? TestingNetworkHandler.Error) else {
                XCTFail()
                return
            }
            XCTAssertEqual(error.code, .statusCodeError)
            XCTAssertNil(error.underlying)
        }
    }

    func testSuccess() async {
        let testingSubject = TestingNetworkHandler()
        let expectedData = Data()
        MockedNetworkSession.returnData = expectedData
        MockedNetworkSession.response = HTTPURLResponse(
            url: URL(string: "google.com")!,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: nil
        )
        
        do {
            let data = try await testingSubject.request(TestEndpoint(url: "google.com", method: .get, params: [:]))
            XCTAssertEqual(data, expectedData)
        } catch {
            XCTFail()
        }
    }
}

final class MockedNetworkSession: NetworkSession {
    static var response: URLResponse?
    static var returnData: Data?
    static let error = NSError(domain: "MockNetworkSession", code: 1)
    static func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let returnData = returnData, let response = response else {
            throw error
        }
        return (returnData, response)
    }
}
