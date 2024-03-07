//
//  MassifsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 10/02/2024.
//

import SwiftUI
import MapKit

struct MassifsView: View {

    @ObservedObject var viewModel: MassifsViewModel

    var body: some View {
        NavigationStack {
            AsyncContentView(
                source: viewModel,
                loadingView: ProgressView()
            ) { massifs in
                MassifsMapView(
                    selectedTag: $viewModel.selectedMassif,
                    mapCameraPosition: $viewModel.mapCameraPosition,
                    massifs: massifs
                )
                .onChange(of: viewModel.selectedMassif) { _, newValue in
                    print(newValue?.toString ?? "nil")
                }
                .onChange(of: viewModel.mapCameraPosition) { _, newValue in
                    print(newValue)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppRouter.shared.createMassifsView()
    }
}
