//
//  RouteAbsentReasonView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct RouteAbsentReasonView: View {
    let reason: String

    var body: some View {
        VStack {
            Text("Route is absent")
                .foregroundColor(.red)
                .font(.headline)
                .padding()

            Text(reason)
                .foregroundColor(.black)
                .padding()
        }
        .padding()
    }
}
