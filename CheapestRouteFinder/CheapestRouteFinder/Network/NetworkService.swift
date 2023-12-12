//
//  NetworkService.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation
import Combine

protocol RouteDataFetching: AnyObject {
    func fetchConnectionsPublisher() -> AnyPublisher<[Connection], Error>
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

final class NetworkService {
    
    // MARK: - Properties
    private let routesUrlString: String
    private let urlSession: URLSession
    
    // MARK: - Initialization
    init(urlSession: URLSession = URLSession.shared,
         routesUrlString: String = Constants.fetchUrl.rawValue) {
        self.urlSession = urlSession
        self.routesUrlString = routesUrlString
    }
    
}

extension NetworkService: RouteDataFetching {
    
    func fetchConnectionsPublisher() -> AnyPublisher<[Connection], Error> {
        guard let url = URL(string: routesUrlString) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == HTTPResponseCode.success.rawValue else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: RouteData.self, decoder: JSONDecoder())
            .map {
                $0.connections
            }
            .eraseToAnyPublisher()
    }
}
