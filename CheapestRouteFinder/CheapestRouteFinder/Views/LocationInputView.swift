//
//  LocationInputView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct LocationInputView: View {
    @Binding var location: String
    @ObservedObject var autocompleteObject: AutocompleteObject
    @Binding var shouldObserveChanges: Bool
    let labelText: String
    let placeholderText: String

    var body: some View {
        VStack(alignment: .leading) {
            AutocompleteTextField(location: $location,
                                  autocompleteObject: autocompleteObject,
                                  shouldObserveChanges: $shouldObserveChanges,
                                  labelText: labelText,
                                  placeholderText: placeholderText)
            AutocompleteListView(suggestions: $autocompleteObject.suggestions,
                                 selectedLocation: $location,
                                 autocompleteObject: autocompleteObject,
                                 shouldObserveChanges: $shouldObserveChanges)
        }
    }
}
