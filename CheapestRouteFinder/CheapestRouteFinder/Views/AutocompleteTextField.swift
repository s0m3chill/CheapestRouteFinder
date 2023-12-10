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
    // workaround to prevent autocomplete re-trigger right after selecting city from list
    @Binding var textFieldShouldObserveChanges: Bool
    var labelText: String
    var placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(labelText)
                    .frame(width: LayoutConstants.prefixTitleWidth.rawValue, alignment: .leading)
                TextField(placeholderText, text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .onChange(of: location) { oldValue, newValue in
                        if textFieldShouldObserveChanges {
                            autocompleteObject.autocomplete(newValue)
                        } else {
                            textFieldShouldObserveChanges = true
                        }
                    }
            }
        }
    }
}

extension AutocompleteTextField: Equatable {
    static func == (lhs: AutocompleteTextField, rhs: AutocompleteTextField) -> Bool {
        return lhs.location == rhs.location &&
        lhs.autocompleteObject === rhs.autocompleteObject &&
        lhs.textFieldShouldObserveChanges == rhs.textFieldShouldObserveChanges &&
        lhs.labelText == rhs.labelText &&
        lhs.placeholderText == rhs.placeholderText
    }
}
