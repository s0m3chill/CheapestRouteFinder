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
    var routes: [Connection] {
        repository.cachedRoutes()
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
    
    private let repository: RoutesRepositoryFetching & RoutesRepositoryCaching
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(repository: RoutesRepositoryFetching & RoutesRepositoryCaching) {
        self.routeViewModelState = .loading
        self.repository = repository
        self.departureAutocomplete = AutocompleteObject(repository: repository)
        self.destinationAutocomplete = AutocompleteObject(repository: repository)
        self.routeStateManager = RouteStateManager(repository: repository)
    }
    
    // MARK: - API
    func fetchRoutes() {
        repository.fetchRoutes()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.routeViewModelState = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] _ in
                self?.routeViewModelState = .loaded
            }
            .store(in: &cancellables)
    }
    
    func calculateCheapestRoute() {
        routeStateManager.calculateCheapestRoute()
    }
}

extension RouteInputViewModel: Equatable {
    static func == (lhs: RouteInputViewModel, rhs: RouteInputViewModel) -> Bool {
        return lhs.routeViewModelState == rhs.routeViewModelState &&
        lhs.routeStateManager == rhs.routeStateManager
    }
}
