//
//  RouteAbsentReasonView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

struct RouteAbsentReasonView: View {
    let reason: String
    private let stringsProvider = StringsProvider()

    var body: some View {
        VStack {
            Text(stringsProvider.string(forKey: .routeIsAbsent))
                .foregroundColor(.red)
                .font(.headline)
                .padding()
            Text(stringsProvider.string(forKey: .reason) + ": " + reason)
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
