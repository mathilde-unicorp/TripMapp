//
//  AppRouter.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import Foundation

class AppRouter {

    // -------------------------------------------------------------------------
    // MARK: - Data Providers
    // -------------------------------------------------------------------------

    private let refugesInfoDataProvider: RefugesInfoDataProviderProtocol

    static var shared: AppRouter = {
        AppRouter(
            refugesInfoDataProvider: RefugesInfoDataProvider()
        )
    }()

    static var mock: AppRouter = {
        AppRouter(
            refugesInfoDataProvider: MockRefugesInfoDataProvider()
        )
    }()

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(refugesInfoDataProvider: RefugesInfoDataProviderProtocol) {
        self.refugesInfoDataProvider = refugesInfoDataProvider
    }

    // -------------------------------------------------------------------------
    // MARK: - Modules
    // -------------------------------------------------------------------------

    func createRefugeDetailView(refugeId: Int) -> RefugeDetailView {
        RefugeDetailView(viewModel: .init(
            refugeId: refugeId,
            dataProvider: self.refugesInfoDataProvider,
            router: self
        ))
    }
}
