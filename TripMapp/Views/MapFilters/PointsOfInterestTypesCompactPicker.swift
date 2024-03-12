//
//  PointsOfInterestsSelectionView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import SwiftUI

struct PointsOfInterestTypesCompactPicker: View {
    @Binding var selectedTypes: Set<POIType>

    var body: some View {
        VStack(spacing: 12.0) {
            ForEach(PointsOfInterestCategory.allCases) { category in
                pointsOfInterestTypeList(for: category)
            }
        }
    }

    @ViewBuilder
    private func pointsOfInterestTypeList(
        for category: PointsOfInterestCategory
    ) -> some View {
        VStack(alignment: .leading) {
            Text(category.title)
                .font(.headline)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(category.types) {
                        pointsOfInterestTypeCell(type: $0)
                    }
                }
                .labelStyle(.iconOnly)
            }
            .scrollIndicators(.hidden)
        }
    }

    @ViewBuilder
    private func pointsOfInterestTypeCell(
        type: PointsOfInterestType
    ) -> some View {
        if self.selectedTypes.contains(type) {
            pointsOfInterestButton(type: type)
                .buttonStyle(.borderedProminent)
        } else {
            pointsOfInterestButton(type: type)
                .buttonStyle(.bordered)
        }
    }

    @ViewBuilder
    private func pointsOfInterestButton(type: PointsOfInterestType) -> some View {
        Button {
            self.selectedTypes.toggle(member: type)
        } label: {
            Label(
                title: { Text(type.title).font(.caption) },
                icon: { Image(systemName: type.systemImage) }
            )
        }
    }
}

#Preview {
    PointsOfInterestTypesCompactPicker(selectedTypes: .constant(.init([.bank, .summit, .hotel])))
}
