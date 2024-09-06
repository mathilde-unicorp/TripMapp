//
//  MapSearchTripPointTypePicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/06/2024.
//

import SwiftUI

/// A Picker for TripPointTypes
struct TripPointTypesPicker<V: View>: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// List of types we want to choose on
    let displayedTypes: [TripPointType]

    /// The selected types on the picker
    @Binding var selectedTypes: [TripPointType]

    var contentBuilder: (_ type: TripPointType) -> V

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(displayedTypes) { type in
                    Button(action: {
                        withAnimation { selectedTypes.toggle(element: type) }
                    }, label: {
                        contentBuilder(type)
                    })
                    .id(type.id)
                }
            }
        }
    }
}

#Preview {
    VStack {
        TripPointTypesPicker(
            displayedTypes: TripPointType.Category.accommodation.types,
            selectedTypes: .constant([.hotel])
        ) { type in
            TripPointTypeLabel(
                tripPointType: type,
                isSelected: [.hotel].contains(type)
            )
        }
    }
}
