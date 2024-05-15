//
//  PointsOfInterestsSelectionView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import SwiftUI

struct PointsOfInterestTypesPicker: View {
    @Binding var selectedTypes: Set<PointsOfInterestType>

    /// Local selection avoid the owner of `selectedType` property 
    /// to be triggered every time the user change its selection on this view
    @State private var localSelection: Set<PointsOfInterestType>

    /// Single selection is used on the `List` to get notified when the user select an item
    @State private var singleSelection: Int?

    @Environment(\.dismiss) private var dismiss

    init(selectedTypes: Binding<Set<PointsOfInterestType>>) {
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

                ForEach(PointsOfInterestCategory.allCases) { category in
                    pointsOfInterestTypeList(for: category)
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
                    self.localSelection.toggle(member: type)
                    self.singleSelection = nil
                }
            }
            .navigationTitle("points_of_interest.title")
        }
    }

    @ViewBuilder
    private func pointsOfInterestTypeList(
        for category: PointsOfInterestCategory
    ) -> some View {
        Section(category.title) {
            ForEach(category.types) {
                pointsOfInterestTypeRow(type: $0)
            }
        }
    }

    @ViewBuilder
    private func pointsOfInterestTypeRow(type: PointsOfInterestType) -> some View {
        HStack {
            Label(type.title, systemImage: type.systemImage)

            Spacer()

            if localSelection.contains(type) {
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview {
    PointsOfInterestTypesPicker(selectedTypes: .constant(.init([
        PointsOfInterestType.summit
    ])))
}
