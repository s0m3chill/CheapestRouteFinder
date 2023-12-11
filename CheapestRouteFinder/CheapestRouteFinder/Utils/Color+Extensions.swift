//
//  Color+Extensions.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import SwiftUI

extension Color {
    static var themeColor: Color {
        let colorSpaceConstant = 255.0
        let redValue: Double = 206.0
        let greenValue: Double = 16.0
        let blueValue: Double = 20.0
        
        return Color(red: redValue / colorSpaceConstant,
                     green: greenValue / colorSpaceConstant,
                     blue: blueValue / colorSpaceConstant)
    }
}

extension UIColor {
    convenience init(_ color: Color) {
        let components = color.cgColor?.components ?? [0.0, 0.0, 0.0]
        self.init(red: CGFloat(components[0]),
                  green: CGFloat(components[1]),
                  blue: CGFloat(components[2]),
                  alpha: CGFloat(color.cgColor?.alpha ?? 1))
    }
}
