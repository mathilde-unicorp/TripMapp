//
//  LoadableMapObject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 19/02/2024.
//

import Foundation
import MapKit
import SwiftUI

protocol LoadableMapObject: ObservableObject {
    associatedtype Output

    var state: LoadingState<Output> { get set }
    var mapCameraPosition: MapCameraPosition { get set }
    var selectedItem: Int? { get set }

    @MainActor func load()
}
