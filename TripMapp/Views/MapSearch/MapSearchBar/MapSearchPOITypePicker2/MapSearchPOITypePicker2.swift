//
//  MapSearchPOITypePicker2.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/07/2024.
//

import SwiftUI

struct MapSearchPOITypePicker2: View {

    let displayedTypes: [[POIType]]

    @Binding var selectedTypes: [POIType]

    init(
        displayedTypes: [POIType] = POIType.allCases,
        selectedTypes: Binding<[POIType]>
    ) {
        // Get 2 lines
        let splitInto = (Double(displayedTypes.count) / 2.0).rounded(.up)

        self.displayedTypes = displayedTypes.chunked(into: Int(splitInto))
        self._selectedTypes = selectedTypes
    }

    var body: some View {
        ScrollView(.horizontal) {
            Grid(alignment: .leading) {
                ForEach(0 ..< displayedTypes.count, id: \.self) { groupIndex in
                    gridRow(types: displayedTypes[groupIndex])
                }
            }
        }
    }

    @ViewBuilder
    private func gridRow(types: [POIType]) -> some View {
        GridRow {
            ForEach(types) { poiType in
                MapSearchPOITypeButton2(
                    type: poiType,
                    isSelectedForMapDisplay: selectedTypes.contains(poiType)
                ) {
                    selectedTypes.toggle(element: poiType)
                }
            }
        }
    }
}

#Preview {
    MapSearchPOITypePicker2(
        displayedTypes: POIType.Category.accommodation.types,
        selectedTypes: .constant([.refuge])
    )
}
