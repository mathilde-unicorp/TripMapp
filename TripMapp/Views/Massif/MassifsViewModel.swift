//
//  MassifsViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 10/02/2024.
//

import Foundation
import SwiftUI

class MassifsViewModel: ObservableObject, LoadableObject {

    // MARK: - UI Properties

    @Published var state: LoadingState<[MapPolygonModel]> = .idle

    // MARK: Private properties

    private let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    // MARK: - Init

    init(
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
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
                let massifs = try await dataProvider.loadMassifs()
                let polygons = massifs.features.map { massif in
                    MapPolygonModel(
                        id: massif.properties.id,
                        name: massif.properties.name,
                        coordinates: massif.geometry.coordinates2D,
                        color: UIColor(hex: massif.properties.colorHexa).swiftUiColor
                    )
                }

                self.state = .loaded(polygons)
            } catch {
                self.state = .failed(error)
            }
        }
    }

    // MARK: - Router

    @ViewBuilder
    func createNextView() -> some View {
        EmptyView()
    }
}
