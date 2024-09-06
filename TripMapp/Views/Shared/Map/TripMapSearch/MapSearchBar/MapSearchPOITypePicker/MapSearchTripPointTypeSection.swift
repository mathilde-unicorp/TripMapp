//
//  MapSearchTripPointTypeSection.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import SwiftUI

struct MapSearchTripPointTypeSection: View {

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
            VStack {
                switch sectionSize {
                case .reduced:
                    reducedTripPointTypeSection(
                        displayedTypes: selectedTypes
                            .merged(with: tripPointTypes.compactMap { $0.tripPointType })
                    )
                case .medium:
                    mediumTripPointTypeSection(
                        displayedTypes: selectedTypes
                            .merged(with: tripPointTypes.compactMap { $0.tripPointType })
                    )
                }
            }
        }
    }

    @ViewBuilder
    private func mediumTripPointTypeSection(displayedTypes: [TripPointType]) -> some View {
        VStack {
            MapSearchTripPointTypeSectionHeader(onShowMore: {
                shouldShowTripPointTypesList = true
            })

            VStack(alignment: .leading) {
                MapSearchTripPointTypePicker(
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
            TripPointTypesPicker(selectedTypes: $selectedTypes)
        }
    }

    @ViewBuilder
    private func reducedTripPointTypeSection(displayedTypes: [TripPointType]) -> some View {
        SmallMapSearchTripPointTypePicker(
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
                    MapSearchTripPointTypeSection(
                        selectedTypes: $selectedTypes,
                        sectionSize: .medium
                    )
                    .padding()

                    MapSearchTripPointTypeSection(
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
