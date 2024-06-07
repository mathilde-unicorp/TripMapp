//
//  PointsOfInterestsSelectionView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import SwiftUI

struct PointsOfInterestTypesPicker: View {
    @Binding var selectedTypes: [PointsOfInterestType]

    @Environment(\.dismiss) private var dismiss

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

    /// Local selection avoid the owner of `selectedType` property 
    /// to be triggered every time the user change its selection on this view
    @State private var localSelection: [PointsOfInterestType]

    /// Single selection is used on the `List` to get notified when the user select an item
    @State private var singleSelection: Int?

    init(selectedTypes: Binding<[PointsOfInterestType]>) {
        self._selectedTypes = selectedTypes
        self.localSelection = selectedTypes.wrappedValue
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        NavigationStack {
            List(selection: $singleSelection) {

                Text("points_of_interest.description")
                    .font(.caption)
                    .listRowBackground(Color.systemBackground)

                pointsOfInterestTypeList(
                    title: "favorites",
                    types: defaultDisplayedTypes
                )

                ForEach(POIType.Category.allCases) { category in
                    pointsOfInterestTypeList(
                        title: category.title,
                        types: category.types
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("done") {
                        // Done behavior
                        self.selectedTypes = localSelection
                        self.dismiss()
                    }
                }
            }
            .onChange(of: singleSelection) { _, newSelection in
                if let newSelection = newSelection,
                   let type = PointsOfInterestType(rawValue: newSelection) {
                    withAnimation {
                        self.localSelection.toggle(element: type)
                        self.singleSelection = nil
                    }
                }
            }
            .navigationTitle("points_of_interest.title")
        }
    }

    @ViewBuilder
    private func pointsOfInterestTypeList(
        title: LocalizedStringKey,
        types: [POIType]
    ) -> some View {
        Section(title) {
            ForEach(types) {
                pointsOfInterestTypeRow(type: $0)
            }
        }
    }

    @ViewBuilder
    private func pointsOfInterestTypeRow(type: PointsOfInterestType) -> some View {
        let isSelected = localSelection.contains(type)

        HStack {
            Label(
                title: { Text(type.title) },
                icon: {
                    Image(systemName: type.systemImage)
                        .foregroundStyle(isSelected ? type.color : .secondary)
                }
            )

            Spacer()

            if isSelected {
                Image(systemName: "eye")
            }
        }
    }
}

#Preview {
    PointsOfInterestTypesPicker(
        selectedTypes: .constant(.init([.summit]))
    )
}
