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
    
    private let repository: RoutesRepositoryFetching
    
    // MARK: - Initialization
    init(repository: RoutesRepositoryFetching) {
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
