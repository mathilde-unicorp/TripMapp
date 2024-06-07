//
//  MapSearchPOITypeSection.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import SwiftUI

struct MapSearchPOITypeSection: View {

    @Binding var selectedTypes: [POIType]

    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private properties
    // -------------------------------------------------------------------------

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id, order: .forward)],
        animation: .default
    )
    private var savedPointsOfInterestsTypeEntity: FetchedResults<PointsOfInterestTypeEntity>

    private var defaultDisplayedTypes: [POIType] {
        savedPointsOfInterestsTypeEntity.compactMap(\.toPointOfInterestType)
    }

    @State private var shouldShowPOITypesList: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        VStack {
            MapSearchPOITypeSectionHeader(onShowMore: {
                shouldShowPOITypesList = true
            })

            VStack(alignment: .leading) {
                MapSearchPOITypePicker(
                    displayedTypes: defaultDisplayedTypes.merge(with: selectedTypes),
                    selectedTypes: $selectedTypes
                )

//                ForEach(POIType.Category.allCases) { category in
//                    VStack(alignment: .leading) {
//                        Text(category.title)
//                            .font(.headline)
//                            .foregroundStyle(.secondary)
//
//                        MapSearchPOITypePicker(
//                            displayedTypes: category.types,
//                            selectedTypes: $selectedTypes
//                        )
//                    }
//                    .padding(.bottom)
//                }
            }
            .padding()
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
        .sheet(isPresented: $shouldShowPOITypesList) {
            PointsOfInterestTypesPicker(selectedTypes: $selectedTypes)
        }
    }
}

#Preview {
    ScrollView {
        MapSearchPOITypeSection(selectedTypes: .constant([.summit, .water]))
            .padding()
    }
    .background(.thinMaterial)
    .environment(
        \.managedObjectContext,
         PersistenceController.preview.container.viewContext
    )
}
