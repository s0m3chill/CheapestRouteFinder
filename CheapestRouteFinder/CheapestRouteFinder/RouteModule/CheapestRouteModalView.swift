//
//  CheapestRouteModalView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct CheapestRouteModalView: View {
    @ObservedObject var viewModel: RouteInputViewModel
    @Binding var isShowingModal: Bool
    
    var body: some View {
        VStack {
            if viewModel.routeAvailabilityStatus.isAvailable {
                CheapestRouteTextView(cheapestRoute: viewModel.cheapestRoute)
                    .equatable()
                CheapestRouteMapView(cheapestRoute: viewModel.cheapestRoute)
                    .frame(height: UIScreen.main.bounds.height * LayoutConstants.mapToScreenHeightProportion.rawValue)
                Text(StringsProvider().string(forKey: .cheapestRoutePrice, viewModel.cheapestPrice))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
            } else {
                RouteAbsentReasonView(reason: viewModel.routeAvailabilityStatus.description)
                    .equatable()
            }
            ActionButton(title: StringsProvider().string(forKey: .close)) {
                isShowingModal = false
            }.equatable()
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
        }
        .padding()
    }
}

extension CheapestRouteModalView: Equatable {
    static func == (lhs: CheapestRouteModalView, rhs: CheapestRouteModalView) -> Bool {
        lhs.viewModel === rhs.viewModel &&
        lhs.isShowingModal == rhs.isShowingModal
    }
}


