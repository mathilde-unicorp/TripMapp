//
//  MKCoordinateRegion.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import Foundation
import SwiftUI
import MapKit

extension MKCoordinateRegion {

    // -------------------------------------------------------------------------
    // MARK: - Default values
    // -------------------------------------------------------------------------

    static var france: MKCoordinateRegion = .init(
        center: .france,
        span: .init(latitudeDelta: 5.0, longitudeDelta: 5.0)
    )
}

// =============================================================================
// MARK: - Conversions
// =============================================================================

extension MKCoordinateRegion {
    var toBbox: RefugesInfo.Bbox? {
        return .init(region: self)
    }
}
