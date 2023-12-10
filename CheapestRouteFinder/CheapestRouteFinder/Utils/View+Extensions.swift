//
//  View+Extensions.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import Foundation
import SwiftUI

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
