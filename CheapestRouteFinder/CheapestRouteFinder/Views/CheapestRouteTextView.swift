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
