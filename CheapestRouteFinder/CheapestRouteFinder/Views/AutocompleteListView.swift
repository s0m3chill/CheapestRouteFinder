//
//  AutocompleteListView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct AutocompleteListView: View {
    @Binding var suggestions: Set<String>
    @Binding var selectedSuggestion: String
    @ObservedObject var autocompleteObject: AutocompleteObject
    @Binding var isSuggestionTapped: Bool
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
                            selectedSuggestion = suggestion
                            autocompleteObject.reset()
                            isSuggestionTapped = false
                            withAnimation {
                                showList = false
                            }
                        }
                    }
                    .frame(maxHeight: showList ? UIScreen.main.bounds.height * heightProportionToScreen : 0)
                    .opacity(showList ? Opacity.opaque.rawValue : Opacity.transparent.rawValue)
                    .animation(.default, value: showList)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: UUID())
                    .onAppear {
                        withAnimation {
                            showList = true
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .onChange(of: suggestions.isEmpty) { oldValue, suggestionsEmpty in
            if suggestionsEmpty {
                withAnimation {
                    showList = false
                }
            }
        }
    }
}

extension AutocompleteListView: Equatable {
    static func == (lhs: AutocompleteListView, rhs: AutocompleteListView) -> Bool {
        return lhs.suggestions == rhs.suggestions &&
        lhs.selectedSuggestion == rhs.selectedSuggestion &&
        lhs.autocompleteObject === rhs.autocompleteObject &&
        lhs.isSuggestionTapped == rhs.isSuggestionTapped
    }
}
