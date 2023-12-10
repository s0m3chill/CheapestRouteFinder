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
                switch viewModel.routeViewModelState {
                case .loading:
                    ProgressView()
                case .error(let errorMessage):
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                case .loaded:
                    LocationInputView(location: $viewModel.routeStateManager.departureLocation,
                                      autocompleteObject: $viewModel.departureAutocomplete,
                                      shouldObserveChanges: $shouldObserveChangesDepartureField,
                                      labelText: StringsProvider().string(forKey: .from),
                                      placeholderText: StringsProvider().string(forKey: .typeDeparture)).equatable()
                    LocationInputView(location: $viewModel.routeStateManager.destinationLocation,
                                      autocompleteObject: $viewModel.destinationAutocomplete,
                                      shouldObserveChanges: $shouldObserveChangesDestinationField,
                                      labelText: StringsProvider().string(forKey: .to),
                                      placeholderText: StringsProvider().string(forKey: .typeDestination)).equatable()
                    ActionButton(isShowingModal: $isShowingModal) {
                        hideKeyboardOnButtonTap()
                        viewModel.findCheapestRoute()
                        isShowingModal = true
                    }.equatable()
                }
            }
            .padding()
            .onAppear(perform: {
                self.viewModel.fetchConnections()
            })
        }
        .sheet(isPresented: $isShowingModal) {
            CheapestRouteModalView(viewModel: viewModel, isShowingModal: $isShowingModal).equatable()
        }
    }
    
    // MARK: - Private
    private func hideKeyboardOnButtonTap() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension RouteInputView: Equatable {
    static func == (lhs: RouteInputView, rhs: RouteInputView) -> Bool {
        return lhs.viewModel == rhs.viewModel
    }
}
