//
//  ActionButton.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(title) {
                action()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.themeColor)
            .foregroundColor(.white)
            .addBorder(Color.white, width: LayoutConstants.borderWidth.rawValue, cornerRadius: LayoutConstants.cornerRadius.rawValue)
            Spacer()
        }
        .padding(.vertical)
    }
}

extension ActionButton: Equatable {
    static func == (lhs: ActionButton, rhs: ActionButton) -> Bool {
        return lhs.title == rhs.title
    }
}
