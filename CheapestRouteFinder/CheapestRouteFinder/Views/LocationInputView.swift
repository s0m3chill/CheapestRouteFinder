//
//  LocationInputView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct LocationInputView: View {
    @Binding var location: String
    @Binding var autocompleteObject: AutocompleteObject
    @Binding var shouldObserveChanges: Bool
    let labelText: String
    let placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            AutocompleteTextField(location: $location,
                                  autocompleteObject: autocompleteObject,
                                  shouldObserveChanges: $shouldObserveChanges,
                                  labelText: labelText,
                                  placeholderText: placeholderText).equatable()
            AutocompleteListView(suggestions: $autocompleteObject.suggestions,
                                 selectedLocation: $location,
                                 autocompleteObject: autocompleteObject,
                                 shouldObserveChanges: $shouldObserveChanges).equatable()
        }
    }
}

extension LocationInputView: Equatable {
    static func == (lhs: LocationInputView, rhs: LocationInputView) -> Bool {
        return lhs.location == rhs.location &&
        lhs.autocompleteObject === rhs.autocompleteObject &&
        lhs.shouldObserveChanges == rhs.shouldObserveChanges &&
        lhs.labelText == rhs.labelText &&
        lhs.placeholderText == rhs.placeholderText
    }
    
}
