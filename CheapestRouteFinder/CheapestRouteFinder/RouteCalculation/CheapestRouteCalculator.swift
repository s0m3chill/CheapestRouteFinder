//
//  CheapestRouteCalculator.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation

struct CheapestRouteCalculator {
    
    // MARK: - Properties
    private var connections: [Connection] = []
    
    // MARK: - Initialization
    init(connections: [Connection]) {
        self.connections = connections
    }
    
    // MARK: - API
    func calculateCheapestRoute(from start: String, to destination: String) -> (route: [Connection], price: Int) {
        var routes = [[Connection]]()
        var visited = Set<String>()
        var currentRoute = [Connection]()
        
        calculateCheapestRouteRecursive(from: start,
                                        to: destination,
                                        visited: &visited,
                                        currentRoute: &currentRoute,
                                        routes: &routes)
        
        let cheapestRoute = routes.min { $0.map { $0.price }.reduce(0, +) < $1.map { $0.price }.reduce(0, +) } ?? []
        let cheapestPrice = price(forRoute: cheapestRoute)
        
        return (cheapestRoute, cheapestPrice)
    }
    
    // MARK: - Private
    private func calculateCheapestRouteRecursive(from current: String,
                                                 to destination: String,
                                                 visited: inout Set<String>,
                                                 currentRoute: inout [Connection],
                                                 routes: inout [[Connection]]) {
        if current == destination {
            routes.append(currentRoute)
            return
        }
        
        visited.insert(current)
        
        let possibleConnections = connections.filter { $0.from == current && !visited.contains($0.to) }
        for connection in possibleConnections {
            currentRoute.append(connection)
            calculateCheapestRouteRecursive(from: connection.to,
                                            to: destination,
                                            visited: &visited,
                                            currentRoute: &currentRoute,
                                            routes: &routes)
            currentRoute.removeLast()
        }
        
        visited.remove(current)
    }
    
    private func price(forRoute connections: [Connection]) -> Int {
        return connections.reduce(0) { $0 + $1.price }
    }
    
}
