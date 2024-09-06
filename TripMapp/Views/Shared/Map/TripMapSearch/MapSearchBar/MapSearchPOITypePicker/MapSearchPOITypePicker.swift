//
//  MapSearchTripPointTypePicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/06/2024.
//

import SwiftUI

struct MapSearchTripPointTypePicker: View {

    let displayedTypes: [TripPointType]

    @Binding var selectedTypes: [TripPointType]

    init(
        displayedTypes: [TripPointType] = TripPointType.allCases,
        selectedTypes: Binding<[TripPointType]>
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
                        TripPointTypeLabel(
                            tripPointType: type,
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
        MapSearchTripPointTypePicker(
            displayedTypes: TripPointType.Category.accommodation.types,
            selectedTypes: .constant([.hotel])
        )

        MapSearchTripPointTypePicker(
            displayedTypes: TripPointType.Category.service.types,
            selectedTypes: .constant([.foodstuffProvisions])
        )

        MapSearchTripPointTypePicker(
            displayedTypes: TripPointType.Category.hiking.types,
            selectedTypes: .constant([.summit])
        )
    }
}
