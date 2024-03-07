//
//  PointsOfInterestsCategory.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import Foundation
import MapKit
import SwiftUI

protocol PointsOfInterestsCategory {
    var name: String { get }
    var image: Image { get }

    var defaultQuery: String { get }
    var mkPointOfInterestFilter: MKPointOfInterestFilter { get }
}
