//
//  MapSearchByPOITypeView+ViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/07/2024.
//

import Foundation
import MapKit

class TripMapSearchDataSource: ObservableObject {

    let mapItemsRepository: TripMapItemsRepository

    // -------------------------------------------------------------------------
    // MARK: - Published
    // -------------------------------------------------------------------------

    @Published var searchResults: [TripMapMarker.ViewModel] = []
    @Published var loadingState: LoadingState<[TripMapMarker.ViewModel]> = .idle

    private let defaultRegion: MKCoordinateRegion = .france

    private var searchTask: Task<Void, Never>?

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(mapItemsRepository: TripMapItemsRepository = .shared) {
        self.mapItemsRepository = mapItemsRepository
    }

    // -------------------------------------------------------------------------
    // MARK: - Requests
    // -------------------------------------------------------------------------

    @MainActor
    func searchMapItems(
        ofTypes types: [PointsOfInterestType],
        on region: MKCoordinateRegion?
    ) {
        self.loadingState = .loading

        self.searchTask?.cancel()
        self.searchTask = Task.detached(priority: .background) { [weak self] in
            guard let self = self else { return }

            let region = region ?? self.defaultRegion

            do {
                let items = try await self.mapItemsRepository
                    .searchMapItems(types: types, region: region)

                let newMarkers = items.toTripMapMarkerViewModels()

                self.searchResults = newMarkers
                self.loadingState = .loaded(newMarkers)
            } catch {
                print("Got error while getting map items of types \(types): \(error)")
                self.loadingState = .failed(error)
            }
        }
    }
}
