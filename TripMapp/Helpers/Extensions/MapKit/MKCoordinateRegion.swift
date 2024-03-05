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
    static var france: MKCoordinateRegion = .init(
        center: .france,
        span: .init(latitudeDelta: 5.0, longitudeDelta: 5.0)
    )

}
