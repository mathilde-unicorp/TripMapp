//
//  AppSettings.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/07/2024.
//

import Foundation
import Unicorp_DataTypesLibrary

// =============================================================================
// MARK: - Shared
// =============================================================================

class AppSettings {

    static var shared = AppSettings()

    private init() {}

    /// The last registered app version
    @UserDefaultsItem("lastAppVersion", defaultValue: "0.0.1")
    var lastAppVersion: String

    /// Should make the setup of the "favorite Points of Interests"
    @UserDefaultsItem("shouldSetupFavoritePOITypes", defaultValue: true)
    var shouldSetupFavoritePOITypes: Bool
}
