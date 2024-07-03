//
//  MapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI

struct MapMarkerInfoView: View {

    var mapItem: TripMapMarker.ViewModel

    @EnvironmentObject private var router: AppRouter

    @State private var openDetailedResult: TripMapMarker.ViewModel?

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
            if case .refugesInfo(let refugeId) = item.source {
                router.createRefugeDetailView(refugeId: refugeId)
            }
        }
    }
}

#Preview {
    MapMarkerInfoView(mapItem: .mocks.first!)
        .environmentObject(AppRouter.mock)
}
