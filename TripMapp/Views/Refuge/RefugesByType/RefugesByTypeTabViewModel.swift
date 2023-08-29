//
//  RefugesByTypeTabViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import SwiftUI

class RefugesByTypeTabViewModel: ObservableObject {

    // MARK: - UI Properties

    @Published var selectedTab: RefugePointType? = .hut

    let tabs: [RefugePointType]

    // MARK: Private properties

    let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    // MARK: - Init

    init(
        tabs: [RefugePointType],
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.tabs = tabs
        self.dataProvider = dataProvider
        self.router = router
    }

    // MARK: - Requests


    // MARK: - Router

//    @ViewBuilder
//    func createRefugesView(refugeType: RefugePointType) -> some View {
//        print("create refuges view with point type: \(refugeType.name)")
//        return router.createRefugesView(refugeType: refugeType)
//    }
}
