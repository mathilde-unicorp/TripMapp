//
//  RefugeDetailView+refugeDescriptionView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI
import MapKit

extension RefugeDetailView {

    @ViewBuilder
    static func refugeDescriptionView(_ refuge: RefugesInfo.Refuge) -> some View {
        ScrollView {
            VStack {
                MapView(coordinate: refuge.geometry.coordinated2D)
                    .frame(height: 400)

                VStack {
                    HStack {
                        Text(refuge.properties.name)
                            .font(.title)

                        Spacer()

                        Text("Fiche \(String(format: "%d", refuge.properties.id))")
                            .font(.caption)
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

struct RefugeDetailView_refugeDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        RefugeDetailView.refugeDescriptionView(
            RefugesInfo.Feature(
                properties: RefugesInfo.Point(id: 0, name: "Refuge name", type: .bivouac),
                geometry: .init(coordinates: [0, 0])
            )
        )
    }
}
