//
//  ActionButton.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import SwiftUI

struct ActionButton: View {
    @Binding var isShowingModal: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(StringsProvider().string(forKey: .findCheapestRoute)) {
                action()
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
