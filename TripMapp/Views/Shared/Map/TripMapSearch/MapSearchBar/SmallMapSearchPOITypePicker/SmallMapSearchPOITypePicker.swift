//
//  SmallMapSearchTripPointTypePicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI

struct SmallMapSearchTripPointTypePicker: View {

    /// All the types that should be displayed on the picker
    let displayedTypes: [TripPointType]

    /// The current types selection on displayed types
    @Binding var selectedTypes: [TripPointType]

    private let shouldShowEllipsis: Bool

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(
        displayedTypes allDisplayedTypes: [TripPointType] = TripPointType.allCases,
        selectedTypes: Binding<[TripPointType]>
    ) {
        // Keep only the 3 first of displayed types
        self.displayedTypes = Array(allDisplayedTypes.prefix(3))
        self._selectedTypes = selectedTypes

        self.shouldShowEllipsis = displayedTypes.count != allDisplayedTypes.count
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .top, spacing: 4.0) {
                ForEach(displayedTypes) { type in
                    Button(action: {
                        withAnimation { selectedTypes.toggle(element: type) }
                    }, label: {
                        TripPointTypeImage(
                            tripPointType: type,
                            isSelected: selectedTypes.contains(type)
                        )
                    })
                    .id(type.id)
                }
            }

            if shouldShowEllipsis {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(.tertiary)

            }
        }
    }
}

#Preview {
    SmallMapSearchTripPointTypePicker(
        displayedTypes: TripPointType.Category.accommodation.types,
        selectedTypes: .constant([.cottage])
    )
    .padding()
    .background(Color.secondarySystemBackground)
}
