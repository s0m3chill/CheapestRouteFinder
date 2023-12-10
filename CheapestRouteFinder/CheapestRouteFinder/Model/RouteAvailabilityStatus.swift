//
//  RouteAvailabilityStatus.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation

enum RouteAvailabilityStatus: Equatable {
    case available
    case routeDoesNotExist
    case sameLocation(String)
    case noLocation
    
    var isAvailable: Bool {
        return self == .available
    }
    
    var description: String {
        switch self {
        case .available:
            return "Route is available"
        case .routeDoesNotExist:
            return "Route doesn't exist"
        case .sameLocation(let city):
            return "Departure and destination are the same: \(city)"
        case .noLocation:
            return "Departure and/or destination are empty"
        }
    }
}
