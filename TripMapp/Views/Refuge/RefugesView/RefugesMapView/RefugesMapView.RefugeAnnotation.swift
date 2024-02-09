//
//  RefugeAnnotation.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import SwiftUI
import MapKit

// -------------------------------------------------------------------------
// MARK: - View Model
// -------------------------------------------------------------------------

extension RefugesMapView {
    struct AnnotationViewModel {
        let id: RefugeId
        let name: String
        let coordinates: CLLocationCoordinate2D
        let image: Image
    }
}

// -------------------------------------------------------------------------
// MARK: - View
// -------------------------------------------------------------------------

extension RefugesMapView {

    struct AnnotationView: View {
        var image: Image

        var body: some View {
            image
                .resizable()
                .scaledToFit()
                .padding(8)
                .background(Color.systemBackground)
                .cornerRadius(8)
                .foregroundColor(.green)
                .shadow(radius: 4) // Add a subtle shadow
        }
    }
}


#Preview {
    RefugesMapView.AnnotationView(
        image: Image(systemName: "tent")
    )
}
