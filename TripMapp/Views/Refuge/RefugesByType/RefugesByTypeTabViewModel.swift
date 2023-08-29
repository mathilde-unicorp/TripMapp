//
//  RefugesByTypeTabViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import SwiftUI

class RefugesByTypeTabViewModel: ObservableObject {

    // MARK: - UI Properties

    @Published var selectedTab: RefugesInfo.PointType? = .hut

    let tabs: [RefugesInfo.PointType]

    // MARK: Private properties

    private let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    // MARK: - Init

    init(
        tabs: [RefugesInfo.PointType],
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.tabs = tabs
        self.dataProvider = dataProvider
        self.router = router
    }

    // MARK: - Requests


    // MARK: - Router

    @ViewBuilder
    func createRefugesView(refugeType: RefugesInfo.PointType) -> some View {
        router.createRefugesView(refugeType: refugeType)
    }
}
