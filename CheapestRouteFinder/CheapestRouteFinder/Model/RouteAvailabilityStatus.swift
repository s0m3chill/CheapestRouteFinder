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
            return StringsProvider().string(forKey: .routeIsAvailable)
        case .routeDoesNotExist:
            return StringsProvider().string(forKey: .routeDostNotExist)
        case .sameLocation(let city):
            return StringsProvider().string(forKey: .routeSameLocation, city)
        case .noLocation:
            return StringsProvider().string(forKey: .routeNoLocation)
        }
    }
}
