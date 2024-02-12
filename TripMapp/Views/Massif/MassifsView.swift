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
        AsyncContentView(
            source: viewModel,
            loadingView: ProgressView()
        ) { massifs in
            MassifsMapView(selectedTag: $selectedMassif, massifs: massifs)
                .onChange(of: selectedMassif) {
                    print(selectedMassif)
                }
        }
    }
}

#Preview {
    AppRouter.shared.createMassifsView()
}
