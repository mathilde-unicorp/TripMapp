//
//  MapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI

struct MapMarkerInfoView: View {

    var mapItem: RefugesInfoMarker.ViewModel

    @EnvironmentObject private var router: AppRouter

    @State private var openDetailedResult: RefugesInfoMarker.ViewModel?

    var body: some View {
        VStack(alignment: .leading) {
            Label(
                mapItem.name,
                systemImage: mapItem.systemImage
            )
            .font(.headline)

            Button(action: {
                openDetailedResult = mapItem
            }, label: {
                Text("open_details_title")
            })
        }
//        .frame(height: 38)
        .sheet(item: $openDetailedResult) { item in
            router.createRefugeDetailView(refugeId: item.refugeId)
        }
    }
}

#Preview {
    MapMarkerInfoView(
        mapItem: .init(refugeInfoResult: MockRefuges.refuges.first!.toLightPoint)
    )
    .environmentObject(AppRouter.mock)
}
