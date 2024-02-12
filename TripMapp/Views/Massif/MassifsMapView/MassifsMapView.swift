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
    let massifs: [MapPolygonModel]

    var body: some View {
        Map(selection: $selectedTag) {
            ForEach(massifs, id: \.id) { massif in
                MapPolygon(coordinates: massif.coordinates)
                    .foregroundStyle(massif.color.opacity(0.5))
                    .stroke(massif.color, lineWidth: 3.0)

                Marker(
                    massif.name,
                    systemImage: "mountain.2",
                    coordinate: massif.coordinates.calculateCentralPoint() ?? .zero
                )
                .tint(massif.color)

            }
        }
    }
}

#Preview {
    MassifsMapView(
        selectedTag: .constant(nil),
        massifs: [
            .init(id: 0, name: "Test", coordinates: MockRefugesInfoDataProvider().massifs.first!.geometry.coordinates2D, color: .green)
        ])
}
