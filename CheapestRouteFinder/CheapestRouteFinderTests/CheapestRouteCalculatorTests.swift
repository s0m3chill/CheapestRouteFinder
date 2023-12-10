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
        
        let connections = [
            Connection(from: "A", to: "B", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 1, long: 1)), price: 10),
            Connection(from: "B", to: "C", coordinates: .init(from: .init(lat: 1, long: 1), to: .init(lat: 2, long: 2)), price: 15),
            Connection(from: "C", to: "D", coordinates: .init(from: .init(lat: 2, long: 2), to: .init(lat: 3, long: 3)), price: 5),
            Connection(from: "A", to: "D", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 50),
        ]
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
