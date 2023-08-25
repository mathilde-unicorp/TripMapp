//
//  RefugeDetailViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import Foundation

/**
 A view model class for managing the details of a refuge.

 This class is responsible for loading and managing the data of a refuge. It conforms to the `ObservableObject` protocol, allowing it to be observed for changes.

 - Published properties:
 - `refuge`: An optional `RefugesInfo.RefugePoint` object representing the refuge. This property is marked as `@Published`, indicating that it will automatically notify observers when its value changes.
 - `hasError`: A boolean value indicating whether an error occurred while loading the refuge data. This property is marked as `@Published`.
 - `isLoading`: A boolean value indicating whether the refuge data is currently being loaded. This property is marked as `@Published`.

 - Private properties:
 - `refugeId`: An integer representing the ID of the refuge.
 - `dataProvider`: An object conforming to the `RefugesInfoDataProviderProtocol` protocol, responsible for providing the refuge data.
 - `router`: An instance of the `AppRouter` class, used for navigating to other screens in the app.

 - Parameters:
 - `refugeId`: An integer representing the ID of the refuge.
 - `dataProvider`: An object conforming to the `RefugesInfoDataProviderProtocol` protocol, responsible for providing the refuge data.
 - `router`: An instance of the `AppRouter` class, used for navigating to other screens in the app.

 - Throws:
 This method can throw an error of type `Error` if an error occurs while loading the refuge data.

 - Returns:
 A `RefugesInfo.RefugePoint` object representing the loaded refuge data.
 */
class RefugeDetailViewModel: ObservableObject {

    @Published var refuge: RefugesInfo.RefugePoint?
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true

    private let refugeId: Int

    private let dataProvider: RefugesInfoDataProviderProtocol
    private let router: AppRouter

    init(refugeId: Int, dataProvider: RefugesInfoDataProviderProtocol, router: AppRouter) {
        self.refugeId = refugeId
        self.dataProvider = dataProvider
        self.router = router
    }

    func loadRefuge() async throws -> RefugesInfo.RefugePoint {
        try await dataProvider.loadRefuge(id: self.refugeId)
    }
}
