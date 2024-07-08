//
//  MapSearchPOITypeSection.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import SwiftUI

struct MapSearchPOITypeSection: View {

    @Binding var selectedTypes: [POIType]

    let sectionSize: SearchBarSize

    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private properties
    // -------------------------------------------------------------------------

    @FetchRequest(
        fetchRequest: PointsOfInterestTypeEntity.allPointsOfInterestTypes,
        transaction: .init(animation: .default)
    )
    private var savedPOITypeEntity: FetchedResults<PointsOfInterestTypeEntity>

    private var defaultDisplayedTypes: [POIType] {
        let savedPOIType = savedPOITypeEntity.compactMap(\.toPointOfInterestType)

        return selectedTypes.merged(with: savedPOIType)
    }

    @State private var shouldShowPOITypesList: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        switch sectionSize {
        case .reduced:
            reducedPOITypeSection()
        case .medium:
            mediumPOITypeSection()
        }
    }

    @ViewBuilder
    private func mediumPOITypeSection() -> some View {
        VStack {
            MapSearchPOITypeSectionHeader(onShowMore: {
                shouldShowPOITypesList = true
            })

            VStack(alignment: .leading) {
                MapSearchPOITypePicker(
                    displayedTypes: defaultDisplayedTypes,
                    selectedTypes: $selectedTypes
                )

                if defaultDisplayedTypes.isEmpty {
                    Text("map_search_bar.point_of_interests.empty")
                        .font(.caption)
                }
            }
            .padding()
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
        .sheet(isPresented: $shouldShowPOITypesList) {
            PointsOfInterestTypesPicker(selectedTypes: $selectedTypes)
        }
    }

    @ViewBuilder
    private func reducedPOITypeSection() -> some View {
        SmallMapSearchPOITypePicker(
            displayedTypes: defaultDisplayedTypes,
            selectedTypes: $selectedTypes
        )
    }
}

struct MapSearchPOITypeSection_Previews: PreviewProvider {

    struct ContainerView: View {
        @State private var selectedTypes: [POIType] = [.summit, .water]

        var body: some View {
            ScrollView {
                MapSearchPOITypeSection(
                    selectedTypes: $selectedTypes,
                    sectionSize: .medium
                )
                .padding()
            }
            .background(.thinMaterial)
            .configureEnvironmentForPreview()
        }
    }

    static var previews: some View {
        ContainerView()
    }
}
