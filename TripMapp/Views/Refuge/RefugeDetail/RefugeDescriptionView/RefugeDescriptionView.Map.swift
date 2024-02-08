//
//  RefugeDescriptionView.Map.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import SwiftUI
import MapKit

extension RefugeDescriptionView {
    struct Map: View {
        let annotation: RefugesMapView.AnnotationViewModel

        init(annotation: RefugesMapView.AnnotationViewModel) {
            self.annotation = annotation
        }

        init(viewModel: ViewModel) {
            self.annotation = .init(
                id: viewModel.placeID,
                name: "",
                coordinates: viewModel.coordinate,
                image: viewModel.icon
            )
        }

        var body: some View {
            RefugesMapView(
                annotations: .constant([annotation]),
                mapCameraPosition: .constant(.region(.init(
                    center: annotation.coordinates,
                    span: .init(latitudeDelta: 0.02, longitudeDelta: 0.02)
                ))),
                selectedRefugeId: .constant(nil)
            )
        }
    }
}

#Preview {
    RefugeDescriptionView.Map(viewModel: .mock())
}
