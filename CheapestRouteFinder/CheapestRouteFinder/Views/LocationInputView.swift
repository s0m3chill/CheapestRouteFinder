//
//  LocationInputView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct LocationInputView: View {
    @Binding var userInput: String
    @Binding var autocompleteObject: AutocompleteObject
    @State private var textFieldShouldObserveChanges: Bool = true
    let labelText: String
    let placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            AutocompleteTextField(userInput: $userInput,
                                  autocompleteObject: autocompleteObject,
                                  textFieldShouldObserveChanges: $textFieldShouldObserveChanges,
                                  labelText: labelText,
                                  placeholderText: placeholderText)
            .equatable()
            AutocompleteListView(suggestions: $autocompleteObject.suggestions,
                                 selectedSuggestion: $userInput,
                                 autocompleteObject: autocompleteObject,
                                 isSuggestionTapped: $textFieldShouldObserveChanges)
            .equatable()
        }
    }
}

extension LocationInputView: Equatable {
    static func == (lhs: LocationInputView, rhs: LocationInputView) -> Bool {
        return lhs.userInput == rhs.userInput &&
        lhs.autocompleteObject === rhs.autocompleteObject &&
        lhs.textFieldShouldObserveChanges == rhs.textFieldShouldObserveChanges &&
        lhs.labelText == rhs.labelText &&
        lhs.placeholderText == rhs.placeholderText
    }
    
}
