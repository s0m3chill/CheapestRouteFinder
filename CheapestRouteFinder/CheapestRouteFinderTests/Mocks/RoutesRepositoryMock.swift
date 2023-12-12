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
    var routes: [Connection] = []
    var error: Error?
    
    enum IsCalled {
        case none
        case fetchRoutes
        case cachedRoutes
        case cachedCities
    }
    var isCalled: IsCalled = .none
    
    // MARK: - API
    func fetchRoutes() -> AnyPublisher<[Connection], Error> {
        isCalled = .fetchRoutes
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(routes).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    func cachedRoutes() -> [Connection] {
        isCalled = .cachedRoutes
        return routes
    }
    
    func cachedCities() -> Set<String> {
        isCalled = .cachedCities
        return Set()
    }
}
