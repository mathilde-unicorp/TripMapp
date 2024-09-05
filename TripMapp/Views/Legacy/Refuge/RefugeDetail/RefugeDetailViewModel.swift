//
//  RefugeDetailViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import Foundation

class RefugeDetailViewModel: ObservableObject, LoadableObject {

    private let dataProvider: RefugesInfoDataProviderProtocol
    private let router: AppRouter

    private let refugeId: RefugeId

    @Published var state: LoadingState<RefugesInfo.RefugePoint> = .idle

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(refugeId: RefugeId, dataProvider: RefugesInfoDataProviderProtocol, router: AppRouter) {
        self.refugeId = refugeId
        self.dataProvider = dataProvider
        self.router = router
    }

    @MainActor
    func load() {
        state = .loading

        Task { [weak self] in
            guard let self = self else { return }

            do {
                let refuge = try await dataProvider.loadRefuge(id: self.refugeId)

                print(refuge.properties.additionnalInfo)

                await MainActor.run {
                    self.state = .loaded(refuge)
                }
            } catch {
                await MainActor.run {
                    self.state = .failed(error)
                }
            }
        }

    }
}
