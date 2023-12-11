//
//  RouteAvailabilityChecker.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation

struct RouteAvailabilityChecker {
    
    // MARK: - Properties
    let fromLocation: String
    let toLocation: String
    
    // MARK: - API
    func routeAvailabilityStatus() -> RouteAvailabilityStatus {
        if isAnyLocationEmpty() {
            return .noLocation
        }
        if areLocationsSame() {
            return .sameLocation(fromLocation)
        }
        return .available
    }
    
    // MARK: - Private
    private func isAnyLocationEmpty() -> Bool {
        return fromLocation.isEmpty || toLocation.isEmpty
    }
    
    private func areLocationsSame() -> Bool {
        return fromLocation == toLocation
    }
    
}
