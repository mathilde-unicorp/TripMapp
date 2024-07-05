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

// =============================================================================
// MARK: - Equatable
// =============================================================================

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        let lhsCenter = lhs.center
        let lhsSpan = lhs.span
        let rhsCenter = rhs.center
        let rhsSpan = rhs.span

        return lhsCenter.latitude == rhsCenter.latitude
        && lhsCenter.longitude == rhsCenter.longitude
        && lhsSpan.latitudeDelta == rhsSpan.latitudeDelta
        && lhsSpan.longitudeDelta == rhsSpan.longitudeDelta
    }
}
