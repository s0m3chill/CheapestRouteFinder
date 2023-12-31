//
//  RouteViewModelState.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 10.12.2023.
//

import Foundation

enum RouteInputViewModelState: Equatable {
    case loading
    case error(String)
    case loaded
}
