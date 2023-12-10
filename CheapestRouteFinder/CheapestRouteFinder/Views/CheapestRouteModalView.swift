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
                CheapestRouteMapView(cheapestRoute: viewModel.cheapestRoute)
                    .frame(height: UIScreen.main.bounds.height * LayoutConstants.mapToScreenHeightProportion.rawValue)
            } else {
                RouteAbsentReasonView(reason: viewModel.routeAvailabilityStatus.description)
            }
            Text(StringsProvider().string(forKey: .cheapestRoutePrice, viewModel.cheapestPrice))
                .foregroundColor(.black)
                .padding()
            
            Button(StringsProvider().string(forKey: .close)) {
                isShowingModal = false
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
        }
        .padding()
    }
}

struct CheapestRouteTextView: View {
    var cheapestRoute: [Connection]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(cheapestRoute, id: \.self) { connection in
                    Text(StringsProvider().string(forKey: .fromDepartureToDestination, connection.from, connection.to))
                        .font(.body)
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height * LayoutConstants.cheapestRouteTableHeightToScreenProportion.rawValue)
        .padding()
    }
}
