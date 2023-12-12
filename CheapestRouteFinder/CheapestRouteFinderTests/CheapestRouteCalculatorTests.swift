//
//  CheapestRouteCalculatorTests.swift
//  CheapestRouteFinderTests
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import XCTest
@testable import CheapestRouteFinder

final class CheapestRouteCalculatorTests: XCTestCase {
        
    // MARK: - Tests
    func testCalculateCheapestRouteIfRouteExists() {
        let connections = RoutesDataStub().routes
        let sut = CheapestRouteCalculator(connections: connections)
        let (route, price) = sut.calculateCheapestRoute(from: "Tokyo", to: "London")
        XCTAssertEqual(route.map { $0.from }, ["Tokyo"])
        XCTAssertEqual(price, 200)
    }
    
    func testCalculateSuperCheapRoute() {
        var connections = RoutesDataStub().routes
        connections.append(Connection(from: "Tokyo", to: "London",
                                      coordinates: .init(from: .init(lat: 1, long: 1),
                                                         to: .init(lat: 2, long: 2)),
                                      price: 5))
        let sut = CheapestRouteCalculator(connections: connections)
        let (route, price) = sut.calculateCheapestRoute(from: "Tokyo", to: "London")
        XCTAssertEqual(route.map { $0.from }, ["Tokyo"])
        XCTAssertEqual(price, 5)
    }
    
    func testCalculateAlternativeRouteUpdatedPrice() {
        let connections = RoutesDataStub().routesWithUpdatedPriceFromTokyo
        let sut = CheapestRouteCalculator(connections: connections)
        let (route, price) = sut.calculateCheapestRoute(from: "Tokyo", to: "London")
        XCTAssertEqual(route.map { $0.from }, ["Tokyo", "Sydney", "Cape Town"])
        XCTAssertEqual(price, 3)
    }
    
    func testCalculateCheapestRouteIfRouteDoesNotExist() {
        let connections = RoutesDataStub().routes
        let sut = CheapestRouteCalculator(connections: connections)
        let (route, price) = sut.calculateCheapestRoute(from: "Porto", to: "London")
        XCTAssertEqual(route.count, 0)
        XCTAssertEqual(price, 0)
    }
    
    func testCalculateCheapestRouteToSameLocation() {
        let connections = RoutesDataStub().routes
        let sut = CheapestRouteCalculator(connections: connections)
        let (route, price) = sut.calculateCheapestRoute(from: "London", to: "London")
        XCTAssertEqual(route.count, 0)
        XCTAssertEqual(price, 0)
    }
    
}
