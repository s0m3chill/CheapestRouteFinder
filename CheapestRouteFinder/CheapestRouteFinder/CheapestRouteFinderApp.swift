//
//  CheapestRouteFinderApp.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI

@main
struct CheapestRouteFinderApp: App {
    var body: some Scene {
        WindowGroup {
            let coordinator = AppCoordinator()
            coordinator.start()
        }
    }
}

final class AppCoordinator {
    @MainActor func start() -> some View {
        let routesDataFetching: RouteDataFetching = NetworkService()
        let routesRepository: RoutesRepositoryFetching = RoutesRepository(routesDataFetching: routesDataFetching)
        let viewModel = RouteInputViewModel(repository: routesRepository)
        let routesView = RouteInputView(viewModel: viewModel).equatable()
        return routesView
    }
}
