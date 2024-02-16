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
    @Binding var annotations: [MapAnnotationModel]

    /// The camera position on the map
    @Binding var mapCameraPosition: MapCameraPosition

    /// Selected refuge annotation on the map
    @Binding var selectedRefugeId: RefugeId?

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Map(position: $mapCameraPosition, selection: $selectedRefugeId) {
            RefugesMapView.buildMapContent(annotations: annotations)
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Related View Builders
    // -------------------------------------------------------------------------

    @MapContentBuilder
    static func buildMapContent(annotations: [MapAnnotationModel]) -> some MapContent {
        ForEach(annotations, id: \.id) { refuge in
            Annotation(refuge.name, coordinate: refuge.coordinates) {
                RefugeAnnotationView(image: refuge.image)
            }
            .tag(refuge.id)
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
                image: MapPointType.refuge.toRefugesInfoPointType.icon
            ),
            .init(
                id: 1,
                name: "Gite de la Colle St Michel",
                coordinates: .giteDeLaColleStMichel,
                image: MapPointType.refuge.toRefugesInfoPointType.icon
            )
        ]),
        mapCameraPosition: .constant(
            .region(.init(
                center: .france,
                span: .init(latitudeDelta: 15.0, longitudeDelta: 15.0)
            ))
        ),
        selectedRefugeId: .constant(nil)
    )
}
