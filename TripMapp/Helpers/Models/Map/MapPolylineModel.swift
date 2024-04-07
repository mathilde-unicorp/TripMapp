//
//  MapPolylineModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/04/2024.
//

import Foundation
import MapKit
import SwiftUI

protocol MapPolylineModel: Identifiable, Equatable, Hashable {
    var id: UUID { get }
    var name: String { get set }
    var coordinates: [CLLocationCoordinate2D] { get set }
    var color: Color { get set }
}
