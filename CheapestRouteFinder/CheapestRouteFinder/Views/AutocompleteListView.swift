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
    @State var showList = false
    private let heightProportionToScreen: CGFloat = LayoutConstants.autocompleteHeightToScreenProportion.rawValue
    
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
                            withAnimation {
                                showList = false
                            }
                        }
                    }
                    .frame(maxHeight: showList ? UIScreen.main.bounds.height * heightProportionToScreen : 0)
                    .opacity(showList ? 1 : 0)
                    .animation(.default, value: showList)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: UUID())
                    .onAppear {
                        withAnimation {
                            showList = true
                        }
                    }
                }
            }
        }
    }
}

extension AutocompleteListView: Equatable {
    static func == (lhs: AutocompleteListView, rhs: AutocompleteListView) -> Bool {
        return lhs.suggestions == rhs.suggestions &&
        lhs.selectedLocation == rhs.selectedLocation &&
        lhs.autocompleteObject === rhs.autocompleteObject &&
        lhs.shouldObserveChanges == rhs.shouldObserveChanges
    }
}
