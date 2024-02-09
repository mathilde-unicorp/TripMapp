//
//  MapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import SwiftUI
import MapKit

struct RefugesMapView: View {

    /// Annotations to display on the map, representing refuges data
    @Binding var annotations: [AnnotationViewModel]

    /// The camera position on the map
    @Binding var mapCameraPosition: MapCameraPosition

    /// Selected refuge annotation on the map
    @Binding var selectedRefugeId: RefugeId?

    var body: some View {
        Map(position: $mapCameraPosition, selection: $selectedRefugeId) {
            ForEach(annotations, id: \.id) { refuge in
                Annotation(refuge.name, coordinate: refuge.coordinates) {
                    AnnotationView(image: refuge.image)
                }
            }
        }
    }
}

#Preview {
    RefugesMapView(
        annotations: .constant([
            .init(
                id: 0,
                name: "Cabane de Clartan",
                coordinates: .cabaneClartan,
                image: RefugesInfo.DefaultPointType.refuge.toPointType.icon
            ),
            .init(
                id: 1,
                name: "Gite de la Colle St Michel",
                coordinates: .giteDeLaColleStMichel,
                image: RefugesInfo.DefaultPointType.refuge.toPointType.icon
            )
        ]),
        mapCameraPosition: .constant(
            .region(.init(
                center: .cabaneClartan,
                span: .init(latitudeDelta: 2.0, longitudeDelta: 2.0)
            ))
        ),
        selectedRefugeId: .constant(nil)
    )
}
