//
//  CheapestRouteCalculatorTests.swift
//  CheapestRouteFinderTests
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import XCTest
@testable import CheapestRouteFinder

final class CheapestRouteCalculatorTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: CheapestRouteCalculator!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        
        let connections = ConnectionsDataStub().connections
        sut = CheapestRouteCalculator(connections: connections)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    // MARK: - Tests
    func testCalculateCheapestRouteIfRouteExists() {
        let (route, price) = sut.calculateCheapestRoute(from: "A", to: "D")
        XCTAssertEqual(route.map { $0.from }, ["A", "B", "C"])
        XCTAssertEqual(price, 30)
    }
    
    func testCalculateCheapestRouteIfRouteDoesNotExist() {
        let (route, price) = sut.calculateCheapestRoute(from: "B", to: "A")
        XCTAssertEqual(route.count, 0)
        XCTAssertEqual(price, 0)
    }
    
    func testCalculateCheapestRouteToSameLocation() {
        let (route, price) = sut.calculateCheapestRoute(from: "B", to: "B")
        XCTAssertEqual(route.count, 0)
        XCTAssertEqual(price, 0)
    }
    
}
