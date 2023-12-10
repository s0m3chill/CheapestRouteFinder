//
//  RouteStateManager.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import Foundation
import Combine

final class RouteStateManager {
    
    // MARK: - Properties
    @Published var departureLocation: String = ""
    @Published var destinationLocation: String = ""
    @Published var cheapestRoute: [Connection] = []
    @Published var cheapestPrice: Int = 0
    @Published var routeAvailabilityStatus: RouteAvailabilityStatus = .available
    
    private let repository: RoutesRepositoryCaching
    
    // MARK: - Initialization
    init(repository: RoutesRepositoryCaching) {
        self.repository = repository
    }
    
    // MARK: - API
    func calculateCheapestRoute() {
        routeAvailabilityStatus = RouteAvailabilityChecker(fromLocation: departureLocation,
                                                           toLocation: destinationLocation).routeAvailabilityStatus()
        guard routeAvailabilityStatus.isAvailable else {
            cheapestRoute = []
            cheapestPrice = 0
            return
        }
        
        let calculator = CheapestRouteCalculator(connections: repository.cachedConnections())
        let cheapestResult = calculator.calculateCheapestRoute(from: departureLocation, to: destinationLocation)
        cheapestRoute = cheapestResult.route
        cheapestPrice = cheapestResult.price
        routeAvailabilityStatus = cheapestRoute.isEmpty ? .routeDoesNotExist : .available
    }
}

extension RouteStateManager: Equatable {
    static func == (lhs: RouteStateManager, rhs: RouteStateManager) -> Bool {
        return lhs.departureLocation == rhs.departureLocation &&
        lhs.destinationLocation == rhs.destinationLocation &&
        lhs.cheapestRoute == rhs.cheapestRoute &&
        lhs.cheapestPrice == rhs.cheapestPrice &&
        lhs.routeAvailabilityStatus == rhs.routeAvailabilityStatus
    }
}
