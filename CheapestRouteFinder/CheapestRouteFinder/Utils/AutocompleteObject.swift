//
//  AutocompleteObject.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation

final class AutocompleteObject: ObservableObject {
    
    // MARK: - Properties
    @Published var suggestions: Set<String> = Set()
    
    private let suggestionCountToShowAutocomplete = 1
    
    private let repository: RoutesRepositoryCaching
    private var cities: Set<String> {
        return repository.cachedCities()
    }
    
    // MARK: - Initialization
    init(repository: RoutesRepositoryCaching) {
        self.repository = repository
    }
    
    // MARK: - API
    func autocomplete(_ text: String) {
        guard !text.isEmpty else {
            suggestions = []
            return
        }
        
        let newSuggestions = lookup(text: text)
        
        if isSuggestion(in: suggestions, equalTo: text) {
            reset()
        } else {
            suggestions = newSuggestions
        }
    }
    
    func reset() {
        suggestions = []
    }
    
    // MARK: - Private
    private func isSuggestion(in suggestions: Set<String>, equalTo text: String) -> Bool {
        guard let suggestion = suggestions.first, suggestions.count == suggestionCountToShowAutocomplete else {
            return false
        }
        
        return suggestion.lowercased() == text.lowercased()
    }
    
    private func lookup(text: String) -> Set<String> {
        let filteredCities = cities.filter { $0.lowercased().localizedCaseInsensitiveContains(text) }
        return filteredCities
    }
}
