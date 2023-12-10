//
//  RoutesInputViewModelTests.swift
//  CheapestRouteFinderTests
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import XCTest
import Combine
@testable import CheapestRouteFinder

final class RoutesInputViewModelTests: XCTestCase {
    // MARK: - Properties
    private var sut: RouteInputViewModel!
    private var repository: RoutesRepositoryMock!
    private var cancellables = Set<AnyCancellable>()
    private let connections = [
        Connection(from: "A", to: "B", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 1, long: 1)), price: 10),
        Connection(from: "B", to: "C", coordinates: .init(from: .init(lat: 1, long: 1), to: .init(lat: 2, long: 2)), price: 15),
        Connection(from: "C", to: "D", coordinates: .init(from: .init(lat: 2, long: 2), to: .init(lat: 3, long: 3)), price: 5),
        Connection(from: "A", to: "D", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 50),
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        
        let repository = RoutesRepositoryMock()
        self.repository = repository
        sut = RouteInputViewModel(repository: repository)
    }
    
    override func tearDown() {
        super.tearDown()
        
        repository = nil
        sut = nil
    }
    
    // MARK: - Tests
    func testCachedConnectionsIsCalled() {
        repository.connections = connections
        _ = sut.connections
        XCTAssertEqual(repository.isCalled, .cachedConnections)
    }
    
    func testFetchConnectionsIsCalled() {
        sut.fetchConnections()
        XCTAssertEqual(repository.isCalled, .fetchConnections)
    }
    
    func testFetchConnectionsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch connections success")
        
        repository.connections = connections
        sut.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchConnections()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut.connections.count, connections.count)
    }
    
    func testFetchConnectionsFailure() {
        let expectation = XCTestExpectation(description: "Fetch connections failure")
        let error = NSError(domain: "TestError", code: 404, userInfo: nil)
        repository.error = error
        
        sut.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, error.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchConnections()
        wait(for: [expectation], timeout: 1)
    }
    
    func testFindCheapestRouteCalledWithSelectedCities() {
        repository.connections = connections
        sut.departureLocation = "A"
        sut.destinationLocation = "D"
        sut.findCheapestRoute()
        XCTAssertNotEqual(sut.cheapestRoute.count, 0)
    }
    
    func testFindCheapestRouteCalledWithEmptyCities() {
        repository.connections = connections
        sut.findCheapestRoute()
        XCTAssertEqual(sut.routeAvailabilityStatus, .noLocation)
    }
    
    func testFindCheapestRouteCalledWithSameCity() {
        repository.connections = connections
        sut.departureLocation = "A"
        sut.destinationLocation = "A"
        sut.findCheapestRoute()
        XCTAssertEqual(sut.routeAvailabilityStatus, .sameLocation("A"))
    }
    
}

final class RoutesRepositoryMock: RoutesRepositoryFetching {
    
    // MARK: - Properties
    var connections: [Connection] = []
    var error: Error?
    
    enum IsCalled {
        case none
        case fetchConnections
        case cachedConnections
    }
    var isCalled: IsCalled = .none
    
    // MARK: - API
    func fetchConnections() -> AnyPublisher<[Connection], Error> {
        isCalled = .fetchConnections
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(connections).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    func cachedConnections() -> [Connection] {
        isCalled = .cachedConnections
        return connections
    }
}
