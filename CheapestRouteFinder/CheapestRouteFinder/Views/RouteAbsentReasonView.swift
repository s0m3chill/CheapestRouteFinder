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
            Text(StringsProvider().string(forKey: .routeIsAbsent))
                .foregroundColor(.red)
                .font(.headline)
                .padding()
            Text(StringsProvider().string(forKey: .reason) + ": " + reason)
                .foregroundColor(.black)
                .padding()
        }
        .padding()
    }
}

extension RouteAbsentReasonView: Equatable {
    static func == (lhs: RouteAbsentReasonView, rhs: RouteAbsentReasonView) -> Bool {
        return lhs.reason == rhs.reason
    }
}
