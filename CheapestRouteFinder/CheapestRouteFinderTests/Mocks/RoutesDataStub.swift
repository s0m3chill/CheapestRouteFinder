//
//  ConnectionsDataStub.swift
//  CheapestRouteFinderTests
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import Foundation
@testable import CheapestRouteFinder

struct RoutesDataStub {
    let routes = [
        Connection(from: "London", to: "Tokyo", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 1, long: 1)), price: 220),
        Connection(from: "Tokyo", to: "London", coordinates: .init(from: .init(lat: 1, long: 1), to: .init(lat: 2, long: 2)), price: 200),
        Connection(from: "London", to: "Porto", coordinates: .init(from: .init(lat: 2, long: 2), to: .init(lat: 3, long: 3)), price: 50),
        Connection(from: "Tokyo", to: "Sydney", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 100),
        Connection(from: "Sydney", to: "Cape Town", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 1, long: 1)), price: 200),
        Connection(from: "Cape Town", to: "London", coordinates: .init(from: .init(lat: 1, long: 1), to: .init(lat: 2, long: 2)), price: 800),
        Connection(from: "London", to: "New York", coordinates: .init(from: .init(lat: 2, long: 2), to: .init(lat: 3, long: 3)), price: 400),
        Connection(from: "New York", to: "Los Angeles", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 120),
        Connection(from: "Los Angeles", to: "Tokyo", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 150),
    ]
    
    let routesWithUpdatedPriceFromTokyo = [
        Connection(from: "London", to: "Tokyo", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 1, long: 1)), price: 220),
        Connection(from: "Tokyo", to: "London", coordinates: .init(from: .init(lat: 1, long: 1), to: .init(lat: 2, long: 2)), price: 200),
        Connection(from: "London", to: "Porto", coordinates: .init(from: .init(lat: 2, long: 2), to: .init(lat: 3, long: 3)), price: 50),
        Connection(from: "Tokyo", to: "Sydney", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 1),
        Connection(from: "Sydney", to: "Cape Town", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 1, long: 1)), price: 1),
        Connection(from: "Cape Town", to: "London", coordinates: .init(from: .init(lat: 1, long: 1), to: .init(lat: 2, long: 2)), price: 1),
        Connection(from: "London", to: "New York", coordinates: .init(from: .init(lat: 2, long: 2), to: .init(lat: 3, long: 3)), price: 400),
        Connection(from: "New York", to: "Los Angeles", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 120),
        Connection(from: "Los Angeles", to: "Tokyo", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 150),
    ]
}
