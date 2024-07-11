//
//  MapSearchPOITypePicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/06/2024.
//

import SwiftUI

struct MapSearchPOITypePicker: View {

    let displayedTypes: [POIType]

    @Binding var selectedTypes: [POIType]

    init(
        displayedTypes: [POIType] = POIType.allCases,
        selectedTypes: Binding<[POIType]>
    ) {
        self.displayedTypes = displayedTypes
        self._selectedTypes = selectedTypes
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(displayedTypes) { type in
                    Button(action: {
                        withAnimation { selectedTypes.toggle(element: type) }
                    }, label: {
                        PointOfInterestTypeLabel(
                            poiType: type,
                            isSelected: selectedTypes.contains(type)
                        )
                    })
                    .id(type.id)
                }
            }
        }
    }
}

#Preview {
    VStack {
        MapSearchPOITypePicker(
            displayedTypes: POIType.Category.accommodation.types,
            selectedTypes: .constant([.hotel])
        )

        MapSearchPOITypePicker(
            displayedTypes: POIType.Category.service.types,
            selectedTypes: .constant([.foodstuffProvisions])
        )

        MapSearchPOITypePicker(
            displayedTypes: POIType.Category.hiking.types,
            selectedTypes: .constant([.summit])
        )
    }
}
