//
//  RoutesInputViewModel.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation
import Combine

final class RouteInputViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var errorMessage: String?
    @Published var departureLocation: String = ""
    @Published var destinationLocation: String = ""
    @Published var cheapestRoute: [Connection] = []
    @Published var cheapestPrice: Int = 0
    @Published var routeAvailabilityStatus: RouteAvailabilityStatus = .available
    var connections: [Connection] {
        repository.cachedConnections()
    }
    
    private let repository: RoutesRepositoryFetching
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(repository: RoutesRepositoryFetching) {
        self.repository = repository
    }
    
    // MARK: - API
    func fetchConnections() {
        repository.fetchConnections()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] _ in
                self?.errorMessage = nil
            }
            .store(in: &cancellables)
    }
    
    func findCheapestRoute() {
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
