//
//  MassifsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 10/02/2024.
//

import SwiftUI

struct MassifsView: View {

    @ObservedObject var viewModel: MassifsViewModel
    @State private var selectedMassif: Int?

    var body: some View {
        NavigationStack {
            AsyncContentView(
                source: viewModel,
                loadingView: ProgressView()
            ) { massifs in
                MassifsMapView(selectedTag: $selectedMassif, massifs: massifs)
                    .onChange(of: selectedMassif) {
                        print(selectedMassif)
                    }
            }
            .navigationDestination(item: $selectedMassif, destination: { massif in
                viewModel.createRefugesMapView(for: "\(massif)")
            })
        }
    }
}

#Preview {
    NavigationStack {
        AppRouter.shared.createMassifsView()
    }
}
