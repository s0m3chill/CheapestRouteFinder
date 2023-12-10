//
//  AutocompleteListView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct AutocompleteListView: View {
    @Binding var suggestions: Set<String>
    @Binding var selectedLocation: String
    @ObservedObject var autocompleteObject: AutocompleteObject
    @Binding var shouldObserveChanges: Bool
    private let heightProportionToScreen: CGFloat = 0.2
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                if !suggestions.isEmpty {
                    List(Array(suggestions), id: \.self) { suggestion in
                        ZStack {
                            Text(suggestion)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .onTapGesture {
                            selectedLocation = suggestion
                            autocompleteObject.reset()
                            shouldObserveChanges = false
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height * heightProportionToScreen)
                }
            }
        }
    }
}