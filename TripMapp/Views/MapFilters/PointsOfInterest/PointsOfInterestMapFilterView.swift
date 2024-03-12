//
//  PointsOfInterestMapFilterView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/03/2024.
//

import SwiftUI

struct PointsOfInterestMapFilterView: View {
    @Binding var selectedTypes: Set<PointsOfInterestType>

    @State private var isPOITypesSheetVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack {
                Text("points_of_interest.title")
                    .font(.headline)

                Spacer()

                Button("points_of_interest.expand_filters") {
                    isPOITypesSheetVisible.toggle()
                }
            }

            PointsOfInterestTypesCompactPicker(selectedTypes: $selectedTypes)
        }
        .padding()
        .sheet(isPresented: $isPOITypesSheetVisible) {
            PointsOfInterestTypesPicker(selectedTypes: $selectedTypes)
        }
    }
}

#Preview {
    PointsOfInterestMapFilterView(selectedTypes: .constant(.init()))
}
