//
//  NetworkServiceTests.swift
//  CheapestRouteFinderTests
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import XCTest
import Combine
@testable import CheapestRouteFinder

final class NetworkServiceTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: NetworkService!
    private var cancellables = Set<AnyCancellable>()
    private let connections = ConnectionsDataStub().cities
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: sessionConfiguration)
        sut = NetworkService(urlSession: mockSession)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }

    // MARK: - Tests
    func testFetchConnectionsSuccess() {
        guard let mockedData = try? JSONEncoder().encode(RouteData(connections: connections)),
              let url = URL(string: Constants.fetchUrl.rawValue)
        else {
            XCTFail("Response setup failure")
            return
        }
        let expectation = XCTestExpectation(description: "Fetch connections success")
        
        let response = HTTPURLResponse(url: url, statusCode: HTTPResponseCode.success.rawValue, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockURLs = [url: (nil, mockedData, response)]

        sut.fetchConnectionsPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Failure with error: \(error)")
                }
            }, receiveValue: { fetchedConnections in
                XCTAssertEqual(fetchedConnections, self.connections)
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    func testFetchConnectionsFailureInvalidResponse() {
        guard let mockedData = try? JSONEncoder().encode("invalid_response"),
              let url = URL(string: Constants.fetchUrl.rawValue)
        else {
            XCTFail("Response setup failure")
            return
        }
        let expectation = XCTestExpectation(description: "Fetch connections invalid url")
                
        let response = HTTPURLResponse(url: url, statusCode: HTTPResponseCode.success.rawValue, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockURLs = [url: (nil, mockedData, response)]
        
        sut.fetchConnectionsPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but received success")
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received value")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}

