//
//  RefugesMapAndListViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

class RefugesMapAndListViewModel: ObservableObject {

    // MARK: Private Properties

    private let dataProvider: RefugesInfoDataProviderProtocol
    private let router: AppRouter

    private let refuges: [RefugesInfo.LightRefugePoint]

    // MARK: - UI Properties

    @Published var searchText: String {
        didSet { self.updateUI() }
    }

    @Published var filteredRefuges: [RefugesInfo.LightRefugePoint] = []

    @Published var refugesMapAnnotations: [RefugesMapView.AnnotationViewModel] = []

    @Published var mapCameraPosition: MapCameraPosition = .automatic

    // MARK: - Init

    init(
        searchText: String = "",
        refuges: [RefugesInfo.LightRefugePoint],
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.refuges = refuges
        self.searchText = searchText
        self.dataProvider = dataProvider
        self.router = router
        self.mapCameraPosition = .automatic

        self.updateUI()
    }

    // MARK: - Requests

    private func updateUI() {
        self.filteredRefuges = buildFilteredRefuges(
            from: self.refuges, searchText: self.searchText
        )
        self.refugesMapAnnotations = buildRefugesMapAnnotations(
            from: self.filteredRefuges
        )
    }

    private func buildFilteredRefuges(
        from refuges: [RefugesInfo.LightRefugePoint],
        searchText: String
    ) -> [RefugesInfo.LightRefugePoint] {
        if searchText.isEmpty {
            return refuges
        }

        return refuges.filter {
            $0.properties.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    private func buildRefugesMapAnnotations(
        from refuges: [RefugesInfo.LightRefugePoint]
    ) -> [RefugesMapView.AnnotationViewModel] {
        return filteredRefuges.map { refuge in
            RefugesMapView.AnnotationViewModel(
                id: refuge.properties.id,
                name: refuge.properties.name,
                coordinates: refuge.geometry.coordinated2D,
                image: refuge.properties.type.icon
            )
        }
    }

    // MARK: - Router

    @ViewBuilder
    func createRefugeDetailView(refugeId: RefugeId) -> some View {
        router.createRefugeDetailView(refugeId: refugeId)
    }
}
