//
//  MassifsMapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import SwiftUI
import MapKit

struct MassifsMapView: View {
    @Binding var selectedTag: Int?
    @Binding var mapCameraPosition: MapCameraPosition

    let massifs: [RefugesInfoMassifPolygon.ViewModel]

    var body: some View {
        Map(position: $mapCameraPosition, selection: $selectedTag) {
            ForEach(massifs, id: \.id) {
                RefugesInfoMassifPolygon(viewModel: $0)
            }
        }
        .onMapCameraChange(frequency: .onEnd) { mapCamera in
            mapCameraPosition = .region(mapCamera.region)
        }
    }
}

#Preview {
    MassifsMapView(
        selectedTag: .constant(nil),
        mapCameraPosition: .constant(.region(
            .init(center: .france, span: .init(latitudeDelta: 10.0, longitudeDelta: 10.0))
        )),
        massifs: [
            .init(massif: MockMassifs.massifs.first!)
        ])
}
