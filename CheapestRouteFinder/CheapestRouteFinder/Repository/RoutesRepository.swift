//
//  RoutesRepository.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation
import Combine

protocol RoutesRepositoryFetching: AnyObject {
    func fetchRoutes() -> AnyPublisher<[Connection], Error>
}

protocol RoutesRepositoryCaching: AnyObject {
    func cachedRoutes() -> [Connection]
    func cachedCities() -> Set<String>
}

// We can use this repository for both Network and Database fetching
// For the demo purposes I've added only Network
final class RoutesRepository: ObservableObject {
    
    // MARK: - Properties
    private let routesDataFetching: RouteDataFetching
    private var routes: [Connection] = []
    private var cities: Set<String> = Set()
    
    // MARK: - Initialization
    init(routesDataFetching: RouteDataFetching) {
        self.routesDataFetching = routesDataFetching
    }
    
    // MARK: - API
}

extension RoutesRepository: RoutesRepositoryFetching {
    
    func fetchRoutes() -> AnyPublisher<[Connection], Error> {
        return routesDataFetching.fetchConnectionsPublisher()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] connections in
                self?.routes = connections
                self?.cities = connections.reduce(into: Set<String>()) { result, connection in
                    result.insert(connection.from)
                    result.insert(connection.to)
                }
            }, receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Data fetching error: \(error.localizedDescription)")
                }
            })
            .eraseToAnyPublisher()
    }
    
}

extension RoutesRepository: RoutesRepositoryCaching {
    
    func cachedRoutes() -> [Connection] {
        return routes
    }
    
    func cachedCities() -> Set<String> {
        return cities
    }
    
}
