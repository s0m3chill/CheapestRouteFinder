//
//  ConnectionsDataStub.swift
//  CheapestRouteFinderTests
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import Foundation
@testable import CheapestRouteFinder

struct ConnectionsDataStub {
    let connections = [
        Connection(from: "A", to: "B", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 1, long: 1)), price: 10),
        Connection(from: "B", to: "C", coordinates: .init(from: .init(lat: 1, long: 1), to: .init(lat: 2, long: 2)), price: 15),
        Connection(from: "C", to: "D", coordinates: .init(from: .init(lat: 2, long: 2), to: .init(lat: 3, long: 3)), price: 5),
        Connection(from: "A", to: "D", coordinates: .init(from: .init(lat: 0, long: 0), to: .init(lat: 3, long: 3)), price: 50),
    ]
}
