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
    @Published var routeViewModelState: RouteInputViewModelState
    @Published var routeStateManager: RouteStateManager
    @Published var departureAutocomplete: AutocompleteObject
    @Published var destinationAutocomplete: AutocompleteObject
    var connections: [Connection] {
        repository.cachedConnections()
    }
    var routeAvailabilityStatus: RouteAvailabilityStatus {
        routeStateManager.routeAvailabilityStatus
    }
    var cheapestRoute: [Connection] {
        routeStateManager.cheapestRoute
    }
    var cheapestPrice: Int {
        routeStateManager.cheapestPrice
    }
    
    private let repository: RoutesRepositoryFetching
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(repository: RoutesRepositoryFetching,
         departureAutocomplete: AutocompleteObject,
         destinationAutocomplete: AutocompleteObject) {
        self.routeViewModelState = .loading
        self.repository = repository
        self.departureAutocomplete = departureAutocomplete
        self.destinationAutocomplete = destinationAutocomplete
        self.routeStateManager = RouteStateManager(repository: repository)
    }
    
    // MARK: - API
    func fetchConnections() {
        repository.fetchConnections()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.routeViewModelState = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] _ in
                self?.routeViewModelState = .loaded
            }
            .store(in: &cancellables)
    }
    
    func findCheapestRoute() {
        routeStateManager.calculateCheapestRoute()
    }
}

extension RouteInputViewModel: Equatable {
    static func == (lhs: RouteInputViewModel, rhs: RouteInputViewModel) -> Bool {
        return lhs.routeViewModelState == rhs.routeViewModelState &&
        lhs.routeStateManager == rhs.routeStateManager
    }
}
