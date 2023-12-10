//
//  RouteData.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation

struct RouteData: Codable {
    let connections: [Connection]
}

struct Connection: Codable {
    struct Coordinates: Codable, Equatable, Hashable {
        let from: Location
        let to: Location
    }
    
    struct Location: Codable, Equatable, Hashable {
        let lat: Double
        let long: Double
    }
    
    let from: String
    let to: String
    let coordinates: Coordinates
    let price: Int
}

extension Connection: Equatable {
    static func == (lhs: Connection, rhs: Connection) -> Bool {
        return lhs.from == rhs.from &&
        lhs.to == rhs.to &&
        lhs.coordinates == rhs.coordinates &&
        lhs.price == rhs.price
    }
}

extension Connection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinates)
    }
}
