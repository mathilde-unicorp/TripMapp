//
//  PointsOfInterestMapFilterView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/03/2024.
//

import SwiftUI

struct PointsOfInterestMapFilterView: View {
    @Binding var selectedTypes: [TripPointType]

    @State private var isTripPointTypesSheetVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack {
                Text("points_of_interest.title")
                    .font(.headline)

                Spacer()

                Button("points_of_interest.expand_filters") {
                    isTripPointTypesSheetVisible.toggle()
                }
            }

            TripPointTypesPicker(
                displayedTypes: TripPointType.allCases,
                selectedTypes: $selectedTypes
            ) { type in
                TripPointTypeLabel(
                    tripPointType: type,
                    isSelected: selectedTypes.contains(type)
                )
            }
        }
        .sheet(isPresented: $isTripPointTypesSheetVisible) {
            TripPointTypesSelectionView(selectedTypes: $selectedTypes)
        }
    }
}

#Preview {
    PointsOfInterestMapFilterView(selectedTypes: .constant([]))
}
