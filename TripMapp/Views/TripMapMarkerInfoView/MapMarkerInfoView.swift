//
//  MapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI

struct MapMarkerInfoView: View {

    var mapItem: MapMarkerModel

    @EnvironmentObject private var router: AppRouter

    @State private var openDetailedResult: MapMarkerModel?

    var body: some View {
        VStack(alignment: .leading) {
            Label(mapItem.name, systemImage: mapItem.systemImage)
                .font(.headline)

            Button(action: {
                openDetailedResult = mapItem
            }, label: {
                Text("open_details_title")
            })
        }
//        .frame(height: 38)
        .sheet(item: $openDetailedResult) { item in
            router.createRefugeDetailView(refugeId: item.id)
        }
    }
}

#Preview {
    MapMarkerInfoView(mapItem: .init(
        id: 0,
        name: "Gite de la Colle St Michel",
        coordinates: .giteDeLaColleStMichel,
        systemImage: "tent")
    )
    .environmentObject(AppRouter.mock)
}
