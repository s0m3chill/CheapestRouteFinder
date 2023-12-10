//
//  RouteInputView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct RouteInputView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: RouteInputViewModel
    @StateObject var departureAutocomplete: AutocompleteObject
    @StateObject var destinationAutocomplete: AutocompleteObject
    @State private var isShowingModal = false
    @State private var shouldObserveChangesInFromField = true
    @State private var shouldObserveChangesInToField = true
    
    // MARK: - Initialization
    init(viewModel: RouteInputViewModel,
         departureAutocomplete: AutocompleteObject,
         destinationAutocomplete: AutocompleteObject){
        self.viewModel = viewModel
        _departureAutocomplete = StateObject(wrappedValue: departureAutocomplete)
        _destinationAutocomplete = StateObject(wrappedValue: destinationAutocomplete)
    }
    
    // MARK: - View Content
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    LocationInputView(location: $viewModel.fromLocation,
                                      autocompleteObject: departureAutocomplete,
                                      shouldObserveChanges: $shouldObserveChangesInFromField,
                                      labelText: "From:",
                                      placeholderText: "Select departure")
                    LocationInputView(location: $viewModel.toLocation,
                                      autocompleteObject: destinationAutocomplete,
                                      shouldObserveChanges: $shouldObserveChangesInToField,
                                      labelText: "To:",
                                      placeholderText: "Select destination")
                    HStack {
                        Spacer()
                        Button("Find cheapest route!") {
                            viewModel.findCheapestRoute()
                            isShowingModal = true
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical)
                }
            }
            .padding()
            .onAppear(perform: {
                self.viewModel.fetchConnections()
            })
        }
        .sheet(isPresented: $isShowingModal) {
            CheapestRouteModalView(viewModel: viewModel, isShowingModal: $isShowingModal)
        }
    }
}
