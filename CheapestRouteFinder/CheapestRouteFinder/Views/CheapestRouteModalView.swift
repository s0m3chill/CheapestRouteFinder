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
                    .frame(height: UIScreen.main.bounds.height * 0.3)
            } else {
                RouteAbsentReasonView(reason: viewModel.routeAvailabilityStatus.description)
            }
            Text("Cheapest route price: \(viewModel.cheapestPrice)$")
                .foregroundColor(.black)
                .padding()
            
            Button("Close") {
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
            VStack(alignment: .leading, spacing: 8) {
                ForEach(cheapestRoute, id: \.self) { connection in
                    Text("From: \(connection.from) to \(connection.to)")
                        .font(.body)
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.2)
        .padding()
    }
}
