//
//  StringsProvider.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import Foundation

struct StringsProvider {
    
    func string(forKey key: L10N, _ arguments: CVarArg...) -> String {
        let localizedString = NSLocalizedString(key.rawValue, comment: "")
        return String(format: localizedString, arguments: arguments)
    }
    
}
