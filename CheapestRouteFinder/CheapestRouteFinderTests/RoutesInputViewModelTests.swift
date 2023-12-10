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
    private let connections = ConnectionsDataStub().connections
    
    // MARK: - Setup
    @MainActor override func setUp() {
        super.setUp()
        
        let repository = RoutesRepositoryMock()
        self.repository = repository
        sut = RouteInputViewModel(repository: repository,
                                  departureAutocomplete: AutocompleteObject(repository: repository),
                                  destinationAutocomplete: AutocompleteObject(repository: repository))
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
        case cachedCities
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
    
    func cachedCities() -> Set<String> {
        isCalled = .cachedCities
        return Set()
    }
}
