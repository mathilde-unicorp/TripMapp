//
//  HomeMapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI
import MapKit

struct HomeMapView: View {
    var body: some View {
        AppRouter.shared.createRefugesView()
            .environmentObject(AppRouter.shared) // Temp with the current way of working of refuges view
    }
}

#Preview {
    HomeMapView()
        .environment(\.managedObjectContext, .previewViewContext)
}
