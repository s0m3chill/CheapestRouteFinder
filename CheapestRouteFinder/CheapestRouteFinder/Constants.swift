//
//  Constants.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import Foundation

enum Constants: String {
    case fetchUrl = "https://raw.githubusercontent.com/TuiMobilityHub/ios-code-challenge/master/connections.json"
    case pinReuseId = "pin"
}

enum HTTPResponseCode: Int {
    case success = 200
}

enum LayoutConstants: CGFloat {
    case autocompleteHeightToScreenProportion = 0.2
    case cheapestRouteTableHeightToScreenProportion = 0.15
    case mapToScreenHeightProportion = 0.3
}

enum L10N: String {
    case from = "From"
    case to = "To"
    case findCheapestRoute = "FindCheapestRoute"
    case typeDeparture = "TypeDeparture"
    case typeDestination = "TypeDestination"
    case close = "Close"
    case routeIsAbsent = "Route Is Absent"
    case cheapestRoutePrice = "Cheapest Route Price: %d"
    case fromDepartureToDestination = "From: %@ to %@"
    case routeIsAvailable = "RouteIsAvailable"
    case routeDostNotExist = "RouteDoesNotExist"
    case routeNoLocation = "RouteNoLocation"
    case routeSameLocation = "RouteSameLocation %@"
}