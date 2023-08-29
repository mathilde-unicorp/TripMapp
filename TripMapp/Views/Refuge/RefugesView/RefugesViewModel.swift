//
//  RefugesViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import SwiftUI

class RefugesViewModel: ObservableObject {

    // MARK: - UI Properties

    @Published var refuges: [RefugesInfo.LightRefugePoint]?
    @Published var isLoading: Bool = true
    @Published var hasError: Bool = false

    var navigationTitle: String {
        return refugeType?.name.capitalized ?? "All"
    }

    // MARK: Private properties

    private let refugeType: RefugePointType?

    private let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    // MARK: - Init

    init(
        refugeType: RefugePointType?,
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.refugeType = refugeType
        self.dataProvider = dataProvider
        self.router = router
    }

    // MARK: - Requests

    func loadRefuges() async throws -> [RefugesInfo.LightRefugePoint]? {
        print("load refuges with point type: \(refugeType?.toRefugesInfoPointType?.value)")

        return try await dataProvider.loadRefuges(
            massif: .pyrenees,
            type: refugeType?.toRefugesInfoPointType
        )
    }

    // MARK: - Router

    @ViewBuilder
    func createRefugesMapAndListView(refuges: [RefugesInfo.LightRefugePoint]) -> some View {
        router.createRefugesMapAndListView(refuges: refuges)
    }
}
