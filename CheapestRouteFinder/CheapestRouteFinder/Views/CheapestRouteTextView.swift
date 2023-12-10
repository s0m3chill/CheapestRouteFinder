//
//  CheapestRouteTextView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import Foundation
import SwiftUI

struct CheapestRouteTextView: View, Equatable {
    var cheapestRoute: [Connection]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(StringsProvider().string(forKey: .cheapestRouteDescription, cheapestRoute.first?.from ?? "", cheapestRoute.last?.to ?? ""))
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(cheapestRoute, id: \.self) { connection in
                        VStack(alignment: .leading) {
                            Text(StringsProvider().string(forKey: .fromDepartureToDestination, connection.from, connection.to, connection.price))
                                .font(.body)
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: UIScreen.main.bounds.height * LayoutConstants.cheapestRouteTableHeightToScreenProportion.rawValue)
        }
        .padding()
    }
}
