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
        sut.$routeViewModelState
            .dropFirst()
            .sink { state in
                XCTAssertEqual(state, .loaded)
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
        
        sut.$routeViewModelState
            .dropFirst()
            .sink { state in
                XCTAssertEqual(state, .error("The operation couldn’t be completed. (TestError error 404.)"))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchConnections()
        wait(for: [expectation], timeout: 1)
    }
    
    func testFindCheapestRouteCalledWithSelectedCities() {
        repository.connections = connections
        sut.routeStateManager.departureLocation = "A"
        sut.routeStateManager.destinationLocation = "D"
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
        sut.routeStateManager.departureLocation = "A"
        sut.routeStateManager.destinationLocation = "A"
        sut.findCheapestRoute()
        XCTAssertEqual(sut.routeAvailabilityStatus, .sameLocation("A"))
    }
    
}
