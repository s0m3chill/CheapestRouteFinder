//
//  RoutesRepositoryMock.swift
//  CheapestRouteFinderTests
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import Foundation
import Combine
@testable import CheapestRouteFinder

final class RoutesRepositoryMock: RoutesRepositoryFetching & RoutesRepositoryCaching {
    
    // MARK: - Properties
    var connections: [Connection] = []
    var error: Error?
    
    enum IsCalled {
        case none
        case fetchConnections
        case cachedConnections
        case cachedCities
    }
    var isCalled: IsCalled = .none
    
    // MARK: - API
    func fetchConnections() -> AnyPublisher<[Connection], Error> {
        isCalled = .fetchConnections
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(connections).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    func cachedConnections() -> [Connection] {
        isCalled = .cachedConnections
        return connections
    }
    
    func cachedCities() -> Set<String> {
        isCalled = .cachedCities
        return Set()
    }
}
