//
//  PointsOfInterestTypesOverviewPicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/03/2024.
//

import SwiftUI

struct PointsOfInterestTypesCompactPicker: View {
    /// Set of types to display as selected (e.g. they are displayed on the map)
    @Binding var selectedTypes: Set<POIType>

    /// Default types to display even if they are not selected yet
    var defaultTypes: Set<POIType> = .init([.summit, .refuge, .foodstuffProvisions])

    // -------------------------------------------------------------------------
    // MARK: - Private UI
    // -------------------------------------------------------------------------

    /// Display only default types that are not yet selected
    private var defaultTypesDisplayed: [POIType] {
        return Array(defaultTypes)
            .filterWithout { selectedTypes.contains($0) } // Remove types that are selected
            .sorted(by: { $0.id < $1.id }) // ensure they are always displayed on the same order
    }

    /// Display selected types
    private var selectedTypesDisplayed: [POIType] {
        return Array(selectedTypes)
            .sorted(by: { $0.id < $1.id }) // ensure they are always displayed on the same order
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(selectedTypesDisplayed, id: \.id) {
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
