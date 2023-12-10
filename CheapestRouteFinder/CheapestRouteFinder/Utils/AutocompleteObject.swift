//
//  AutocompleteObject.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation

@MainActor
final class AutocompleteObject: ObservableObject {
    
    // MARK: - Properties
    @Published var suggestions: Set<String> = Set()

    private let delayInSeconds: TimeInterval = 0.1
    private let nanosecondsInSecond: Double = 1_000_000_000
        
    private let repository: RoutesRepositoryFetching
    private let cache: AutocompleteCache
    
    private var task: Task<Void, Never>?
    
    // MARK: - Initialization
    init(repository: RoutesRepositoryFetching) {
        self.repository = repository
        cache = AutocompleteCache(source: repository)
    }
    
    // MARK: - API
    func autocomplete(_ text: String) {
        guard !text.isEmpty else {
            suggestions = []
            task?.cancel()
            return
        }
        
        task?.cancel()
        
        task = Task {
            guard ((try? await Task.sleep(nanoseconds: UInt64(delayInSeconds * nanosecondsInSecond))) != nil) else {
                return
            }
            
            guard !Task.isCancelled else {
                return
            }
            
            let newSuggestions = await cache.lookup(prefix: text)
            
            if isSuggestion(in: suggestions, equalTo: text) {
                reset()
            } else {
                suggestions = newSuggestions
            }
        }
    }
    
    func reset() {
        suggestions = []
        task?.cancel()
    }
    
    // MARK: - Private
    private func isSuggestion(in suggestions: Set<String>, equalTo text: String) -> Bool {
        guard let suggestion = suggestions.first, suggestions.count == 1 else {
            return false
        }
        
        return suggestion.lowercased() == text.lowercased()
    }
}

fileprivate actor AutocompleteCache {
    
    // MARK: - Properties
    private let source: RoutesRepositoryFetching
    private var cities: Set<String> {
        return source.cachedCities()
    }
    
    // MARK: - Initialization
    fileprivate init(source: RoutesRepositoryFetching) {
        self.source = source
    }
    
    // MARK: - API
    fileprivate func lookup(prefix: String) -> Set<String> {
        let filteredFrom = cities.filter { $0.lowercased().hasPrefix(prefix.lowercased()) }
        return filteredFrom
    }
}
