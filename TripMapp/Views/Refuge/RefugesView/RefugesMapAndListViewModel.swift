//
//  RefugesMapAndListViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import CoreLocation
import SwiftUI

class RefugesMapAndListViewModel: ObservableObject {

    // MARK: Private Properties

    private let dataProvider: RefugesInfoDataProviderProtocol
    private let router: AppRouter

    private let refuges: [RefugesInfo.LightRefugePoint]

    // MARK: - UI Properties

    @Published var searchText: String

    var filteredRefuges: [RefugesInfo.LightRefugePoint] {
        if searchText.isEmpty {
            return refuges
        }

        return refuges.filter {
            $0.properties.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var mapAnnotationItems: [AnnotationItem] {
        return filteredRefuges.map { refuge in
            AnnotationItem(
                coordinate: refuge.geometry.coordinated2D,
                title: refuge.properties.name,
                image: refuge.properties.type.icon
            )
        }
    }

    var mapCentralPoint: CLLocationCoordinate2D {
        filteredRefuges
            .map { $0.geometry.coordinated2D }
            .calculateCentralPoint() ?? .init(latitude: 0.0, longitude: 0.0)
    }

    // MARK: - Init

    init(
        searchText: String = "",
        refuges: [RefugesInfo.LightRefugePoint],
        dataProvider: RefugesInfoDataProviderProtocol,
        router: AppRouter
    ) {
        self.searchText = searchText
        self.refuges = refuges
        self.dataProvider = dataProvider
        self.router = router
    }

    // MARK: - Requests

    // MARK: - Router

    @ViewBuilder
    func createRefugeDetailView(refugeId: Int) -> some View {
        router.createRefugeDetailView(refugeId: refugeId)
    }
}
