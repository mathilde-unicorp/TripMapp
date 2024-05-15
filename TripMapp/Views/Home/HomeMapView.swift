//
//  HomeMapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI
import MapKit

struct HomeMapView: View {
    @State private var showSearchBar: Bool = false

    var body: some View {
        Map {

        }
        .overlay(alignment: .bottom) {
            MapSearchBarSheet()
        }
    }
}

#Preview {
    HomeMapView()
}
