//
//  RefugesViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import SwiftUI
import MapKit

class RefugesViewModel: ObservableObject, LoadableObject {

    // MARK: Private properties

    private let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    private let refugeType: RefugePointType?

    // MARK: - UI Properties

    @Published var state: LoadingState<[RefugesInfo.LightRefugePoint]> = .idle
    @Published var mapCameraPosition: MapCameraPosition = .region(
        .init(center: .france,
              span: .init(latitudeDelta: 1.0, longitudeDelta: 1.0))
    )

    var navigationTitle: String {
        return refugeType?.name.capitalized ?? "All"
    }

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

    @MainActor
    func load() {
        self.state = .loading

        Task { [weak self] in
            guard let self = self else { return }

            do {
                let refuges = try await dataProvider.loadRefuges(
                    type: refugeType?.toRefugesInfoPointType,
                    bbox: .init(mapCameraPosition: mapCameraPosition)
                )

                self.state = .loaded(refuges.features)
            } catch {
                self.state = .failed(error)
            }
        }
    }

    // MARK: - Router

    @ViewBuilder
    func createRefugesMapAndListView(refuges: [RefugesInfo.LightRefugePoint]) -> some View {
        router.createRefugesMapAndListView(refuges: refuges)
    }
}
