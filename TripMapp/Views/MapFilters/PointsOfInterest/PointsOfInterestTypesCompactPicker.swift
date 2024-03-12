//
//  PointsOfInterestTypesOverviewPicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/03/2024.
//

import SwiftUI

struct PointsOfInterestTypesCompactPicker: View {
    @Binding var selectedTypes: Set<POIType>

    var defaultTypes: Set<POIType> = .init([.summit, .refuge, .foodstuffProvisions])

    /// Display only default types that are not yet selected
    private var defaultTypesDisplayed: [POIType] {
        return Array(defaultTypes).filterWithout { selectedTypes.contains($0) }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(selectedTypes)) {
                    pointsOfInterestButton(type: $0)
                        .buttonStyle(.borderedProminent)
                }

                ForEach(defaultTypesDisplayed) {
                    pointsOfInterestButton(type: $0)
                        .buttonStyle(.bordered)
                }
            }
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
    PointsOfInterestTypesCompactPicker(selectedTypes: .constant(.init([.summit, .hotel, .lake])))
}
