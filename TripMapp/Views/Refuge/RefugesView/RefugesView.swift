//
//  RefugeList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI
import MapKit

struct RefugesView: View {

    @ObservedObject var viewModel: RefugesViewModel

    var body: some View {
        NavigationView {
            VStack {
                AsyncMapView(
                    source: viewModel,
                    loadingView: MapProgressView()
                ) { content in
                    RefugesMapView.buildMapContent(
                        annotations: Array(content.annotations)
                    )

                    // Do not display massifs yet, it's not ready
                    // MassifsMapView.buildMapContent(
                    //    massifs: Array(content.polygons)
                    // )
                }
                .sheet(item: $viewModel.selectedItem) { item in
                    viewModel.createRefugeDetailView(refugeId: item)
                }
            }
        }
    }
}

struct RefugesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppRouter.shared.createRefugesView(refugeType: nil)
        }
    }
}
