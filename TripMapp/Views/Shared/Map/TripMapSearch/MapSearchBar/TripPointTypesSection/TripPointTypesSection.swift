//
//  MapSearchTripPointTypeSection.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import SwiftUI

struct TripPointTypesSection: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    @Binding var selectedTypes: [TripPointType]

    let sectionSize: SearchBarSize

    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private properties
    // -------------------------------------------------------------------------

    @State private var shouldShowTripPointTypesList: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        LocalTripPointTypes { tripPointTypes in
            buildSection(
                displayedTypes: selectedTypes.merged(
                    with: tripPointTypes.compactMap { $0.tripPointType }
                )
            )
        }
    }

    @ViewBuilder
    private func buildSection(displayedTypes: [TripPointType]) -> some View {
        switch sectionSize {
        case .reduced:
            reducedSection(displayedTypes: displayedTypes)
        case .medium:
            mediumSection(displayedTypes: displayedTypes)
        }
    }

    @ViewBuilder
    private func mediumSection(displayedTypes: [TripPointType]) -> some View {
        VStack {
            TripPointTypesSectionHeader(onShowMore: {
                shouldShowTripPointTypesList = true
            })

            VStack(alignment: .leading) {
                TripPointTypesPicker(
                    displayedTypes: displayedTypes,
                    selectedTypes: $selectedTypes
                )

                if displayedTypes.isEmpty {
                    Text("map_search_bar.point_of_interests.empty")
                        .font(.caption)
                }
            }
            .padding()
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
        .sheet(isPresented: $shouldShowTripPointTypesList) {
            TripPointTypesSelectionView(selectedTypes: $selectedTypes)
        }
    }

    @ViewBuilder
    private func reducedSection(displayedTypes: [TripPointType]) -> some View {
        TripPointTypesCompactPicker(
            displayedTypes: displayedTypes,
            selectedTypes: $selectedTypes
        )
    }
}

struct MapSearchTripPointTypeSection_Previews: PreviewProvider {

    struct ContainerView: View {
        @State private var selectedTypes: [TripPointType] = [.summit, .water]

        var body: some View {
            VStack {
                ScrollView {
                    TripPointTypesSection(
                        selectedTypes: $selectedTypes,
                        sectionSize: .medium
                    )
                    .padding()

                    TripPointTypesSection(
                        selectedTypes: $selectedTypes,
                        sectionSize: .reduced
                    )
                    .padding()
                }
            }
            .background(.thinMaterial)
            .configureEnvironmentForPreview()
        }
    }

    static var previews: some View {
        ContainerView()
    }
}
