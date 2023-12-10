//
//  RoutesRepository.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation
import Combine

protocol RoutesRepositoryFetching: AnyObject {
    func fetchConnections() -> AnyPublisher<[Connection], Error>
    func cachedConnections() -> [Connection]
}

// We can use this repository for both Network and Database fetching
// For the demo purposes I've added only Network and cache is 'private(set) var connections: [Connection] = []'
final class RoutesRepository: RoutesRepositoryFetching, ObservableObject {
    
    // MARK: - Properties
    private let routesDataFetching: RouteDataFetching
    private var connections: [Connection] = []
    private(set) var cities: Set<String> = Set()
    
    // MARK: - Initialization
    init(routesDataFetching: RouteDataFetching) {
        self.routesDataFetching = routesDataFetching
    }
    
    // MARK: - API
    func fetchConnections() -> AnyPublisher<[Connection], Error> {
        return routesDataFetching.fetchConnectionsPublisher()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] connections in
                self?.connections = connections
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
    
    func cachedConnections() -> [Connection] {
        return connections
    }
}
