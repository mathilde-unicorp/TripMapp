//
//  MapSearchTripPointTypeSection.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import SwiftUI

struct MapSearchTripPointTypeSection: View {

    @Binding var selectedTypes: [TripPointType]

    let sectionSize: SearchBarSize

    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private properties
    // -------------------------------------------------------------------------

    @FetchRequest(
        fetchRequest: TripPointTypeEntity.sortedFetchRequest(),
        transaction: .init(animation: .default)
    )
    private var savedTripPointTypeEntity: FetchedResults<TripPointTypeEntity>

    private var defaultDisplayedTypes: [TripPointType] {
        let savedTripPointType = savedTripPointTypeEntity.compactMap(\.tripPointType)

        return selectedTypes.merged(with: savedTripPointType)
    }

    @State private var shouldShowTripPointTypesList: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        switch sectionSize {
        case .reduced:
            reducedTripPointTypeSection()
        case .medium:
            mediumTripPointTypeSection()
        }
    }

    @ViewBuilder
    private func mediumTripPointTypeSection() -> some View {
        VStack {
            MapSearchTripPointTypeSectionHeader(onShowMore: {
                shouldShowTripPointTypesList = true
            })

            VStack(alignment: .leading) {
                MapSearchTripPointTypePicker(
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
        .sheet(isPresented: $shouldShowTripPointTypesList) {
            TripPointTypesPicker(selectedTypes: $selectedTypes)
        }
    }

    @ViewBuilder
    private func reducedTripPointTypeSection() -> some View {
        SmallMapSearchTripPointTypePicker(
            displayedTypes: defaultDisplayedTypes,
            selectedTypes: $selectedTypes
        )
    }
}

struct MapSearchTripPointTypeSection_Previews: PreviewProvider {

    struct ContainerView: View {
        @State private var selectedTypes: [TripPointType] = [.summit, .water]

        var body: some View {
            ScrollView {
                MapSearchTripPointTypeSection(
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
