//
//  RefugesViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 29/08/2023.
//

import Foundation
import SwiftUI

class RefugesViewModel: ObservableObject, LoadableObject {

    // MARK: Private properties

    private let router: AppRouter
    private let dataProvider: RefugesInfoDataProviderProtocol

    private let refugeType: RefugePointType?

    // MARK: - UI Properties

    @Published var state: LoadingState<[RefugesInfo.LightRefugePoint]> = .idle

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

    func load() {
        self.state = .loading
        print("load refuges with point type: \(refugeType?.toRefugesInfoPointType?.value ?? "All")")

        Task { [weak self] in
            guard let self = self else { return }

            do {
                let refuges = try await dataProvider.loadRefuges(
                    massif: .pyrenees,
                    type: refugeType?.toRefugesInfoPointType
                )

                self.state = .loaded(refuges)
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
