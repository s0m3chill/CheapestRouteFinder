//
//  AutocompleteTextField.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct AutocompleteTextField: View {
    @Binding var location: String
    @ObservedObject var autocompleteObject: AutocompleteObject
    @Binding var shouldObserveChanges: Bool
    var labelText: String
    var placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(labelText)
            TextField(placeholderText, text: $location)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled()
                .onChange(of: location) { oldValue, newValue in
                    if shouldObserveChanges {
                        // workaround to prevent autocomplete right after selected from list
                        autocompleteObject.autocomplete(newValue)
                    } else {
                        shouldObserveChanges = true
                    }
                }
        }
        .padding()
    }
}