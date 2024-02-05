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

    private let refugeId: Int

    @Published var state: LoadingState<RefugesInfo.RefugePoint> = .idle

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(refugeId: Int, dataProvider: RefugesInfoDataProviderProtocol, router: AppRouter) {
        self.refugeId = refugeId
        self.dataProvider = dataProvider
        self.router = router
    }

    func load() {
        state = .loading

        Task { [weak self] in
            guard let self = self else { return }

            do {
                let refuge = try await dataProvider.loadRefuge(id: self.refugeId)
                self.state = .loaded(refuge)
            } catch {
                self.state = .failed(error)
            }
        }

    }
}
