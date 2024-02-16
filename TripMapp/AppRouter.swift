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

    func createRefugesByTypeTabView(tabs: [RefugePointType]) -> RefugesByTypeTabView {
        RefugesByTypeTabView(viewModel: .init(
            tabs: tabs,
            dataProvider: self.refugesInfoDataProvider,
            router: self
        ))
    }

    func createRefugesView(refugeType: RefugePointType?) -> RefugesView {
        RefugesView(viewModel: .init(
            refugeType: refugeType,
            dataProvider: self.refugesInfoDataProvider,
            router: self
        ))
    }

    func createRefugesMapAndListView(
        initialSearchText: String = "",
        refuges: [RefugesInfo.LightRefugePoint]
    ) -> RefugesMapAndListView {
        RefugesMapAndListView(viewModel: .init(
            searchText: initialSearchText,
            refuges: refuges,
            dataProvider: self.refugesInfoDataProvider,
            router: self
        ))
    }

    func createRefugeDetailView(refugeId: RefugeId) -> RefugeDetailView {
        RefugeDetailView(viewModel: .init(
            refugeId: refugeId,
            dataProvider: self.refugesInfoDataProvider,
            router: self
        ))
    }

    // -------------------------------------------------------------------------
    // MARK: - Massifs
    // -------------------------------------------------------------------------

    func createMassifsView() -> MassifsView {
        MassifsView(viewModel: .init(
            dataProvider: self.refugesInfoDataProvider,
            router: self)
        )
    }
}
