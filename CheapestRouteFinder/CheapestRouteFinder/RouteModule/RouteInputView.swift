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
    @State private var isShowingModal = false
    @State private var shouldObserveChangesDepartureField = true
    @State private var shouldObserveChangesDestinationField = true
    
    // MARK: - Initialization
    init(viewModel: RouteInputViewModel){
        self.viewModel = viewModel
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
                    LocationInputView(location: $viewModel.routeStateManager.departureLocation,
                                      autocompleteObject: $viewModel.departureAutocomplete,
                                      shouldObserveChanges: $shouldObserveChangesDepartureField,
                                      labelText: StringsProvider().string(forKey: .from),
                                      placeholderText: StringsProvider().string(forKey: .typeDeparture))
                    LocationInputView(location: $viewModel.routeStateManager.destinationLocation,
                                      autocompleteObject: $viewModel.destinationAutocomplete,
                                      shouldObserveChanges: $shouldObserveChangesDestinationField,
                                      labelText: StringsProvider().string(forKey: .to),
                                      placeholderText: StringsProvider().string(forKey: .typeDestination))
                    HStack {
                        Spacer()
                        Button(StringsProvider().string(forKey: .findCheapestRoute)) {
                            hideKeyboardOnButtonTap()
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
    
    // MARK: - Private
    private func hideKeyboardOnButtonTap() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
