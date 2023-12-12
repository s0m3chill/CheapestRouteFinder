//
//  CheapestRouteCalculator.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation

///  Dijkstra's algorithm
struct CheapestRouteCalculator {
    // MARK: - Properties
    private var connections: [Connection] = []
    
    // MARK: - Initialization
    init(connections: [Connection]) {
        self.connections = connections
    }
    
    // MARK: - API
    func calculateCheapestRoute(from start: String, to destination: String) -> (route: [Connection], price: Int) {
        var cheapestPrices: [String: Int] = [:]
        var previousNodes: [String: Connection] = [:]
        
        connections.forEach { connection in
            cheapestPrices[connection.from] = Int.max
            cheapestPrices[connection.to] = Int.max
        }
        
        cheapestPrices[start] = 0
        
        var queue = connections.filter { $0.from == start }
        
        while !queue.isEmpty {
            let currentConnection = queue.removeFirst()
            
            if let currentPrice = cheapestPrices[currentConnection.from],
               let priceToCurrent = cheapestPrices[currentConnection.to],
               currentPrice + currentConnection.price < priceToCurrent {
                cheapestPrices[currentConnection.to] = currentPrice + currentConnection.price
                previousNodes[currentConnection.to] = currentConnection
                
                let connectionsFromCurrent = connections.filter { $0.from == currentConnection.to }
                queue.append(contentsOf: connectionsFromCurrent)
            }
        }
        
        var cheapestRoute: [Connection] = []
        var currentNode = destination
        var totalCost = cheapestPrices[destination] ?? 0
        if totalCost == Int.max {
            totalCost = 0
        }
        
        while let previousNode = previousNodes[currentNode] {
            cheapestRoute.insert(previousNode, at: 0)
            currentNode = previousNode.from
        }
        
        return (cheapestRoute, totalCost)
    }
}
