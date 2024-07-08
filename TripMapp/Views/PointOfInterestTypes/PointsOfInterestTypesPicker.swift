//
//  PointsOfInterestsSelectionView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import SwiftUI
import CoreData

struct PointsOfInterestTypesPicker: View {
    @Binding var selectedTypes: [PointsOfInterestType]

    @Environment(\.dismiss) private var dismiss

    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private properties
    // -------------------------------------------------------------------------

    @FetchRequest(
        fetchRequest: PointsOfInterestTypeEntity.allPointsOfInterestTypes,
        transaction: .init(animation: .default)
    )
    private var favoritesPOITypes: FetchedResults<PointsOfInterestTypeEntity>

    /// Local selection avoid the owner of `selectedType` property 
    /// to be triggered every time the user change its selection on this view
    @State private var localSelectionForMapDisplay: [PointsOfInterestType]

    /// Single selection is used on the `List` to get notified when the user select an item
    @State private var listSingleSelection: Int?

    init(selectedTypes: Binding<[PointsOfInterestType]>) {
        self._selectedTypes = selectedTypes
        self.localSelectionForMapDisplay = selectedTypes.wrappedValue
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        NavigationStack {
            List(selection: $listSingleSelection) {

                listDescription()

                ForEach(POIType.Category.allCases) { category in
                    pointsOfInterestTypeSection(
                        title: category.title,
                        types: category.types
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("done") { self.dismiss() }
                }
            }
            .onChange(of: listSingleSelection) { _, newSelection in
                if let newSelection = newSelection,
                   let type = PointsOfInterestType(rawValue: newSelection) {
                    withAnimation {
                        self.localSelectionForMapDisplay.toggle(element: type)
                        self.listSingleSelection = nil
                    }
                }
            }
            .navigationTitle("points_of_interest.title")
        }
        .onDisappear {
            withAnimation {
                self.selectedTypes = localSelectionForMapDisplay
            }
        }
    }

    @ViewBuilder
    private func listDescription() -> some View {
        VStack(alignment: .leading) {
            Text("points_of_interest.description")
        }
        .font(.caption)
        .listRowBackground(Color.systemBackground)

    }

    @ViewBuilder
    private func pointsOfInterestTypeSection(
        title: LocalizedStringKey,
        types: [POIType]
    ) -> some View {
        Section(title) {
            ForEach(types) { type in
                pointOfInterestTypeRow(
                    type: type,
                    isSelectedForMapDisplay: isSelectedForMapDisplay(type: type),
                    isFavorite: isFavorite(type: type)
                )
            }
        }
    }

    @ViewBuilder
    private func pointOfInterestTypeRow(
        type: PointsOfInterestType,
        isSelectedForMapDisplay: Bool,
        isFavorite: Bool
    ) -> some View {
        PointsOfInterestTypeRow(
            type: type,
            isFavorite: isFavorite,
            isSelectedForMapDisplay: isSelectedForMapDisplay
        )
        .swipeActions {
            FavoriteButton(isFavorite: isFavorite) {
                isFavorite ? removeFromFavorite(type: type) : addToFavorite(type: type)
            }
        }
        .contextMenu {
            FavoriteButton(isFavorite: isFavorite) {
                isFavorite ? removeFromFavorite(type: type) : addToFavorite(type: type)
            }

            ShowingOnMapButton(isShowingOnMap: isSelectedForMapDisplay) {
                localSelectionForMapDisplay.toggle(element: type)
            }
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Tools
    // -------------------------------------------------------------------------

    private func isSelectedForMapDisplay(type: PointsOfInterestType) -> Bool {
        return localSelectionForMapDisplay.contains(type)
    }

    private func isFavorite(type: PointsOfInterestType) -> Bool {
        return favoritesPOITypes.contains { $0.id == type.id }
    }

    private func favoritePOITypeEntity(
        from type: PointsOfInterestType
    ) -> PointsOfInterestTypeEntity? {
        return favoritesPOITypes.first(where: { $0.id == type.id })
    }

    // -------------------------------------------------------------------------
    // MARK: - Database saving
    // -------------------------------------------------------------------------

    private func addToFavorite(type: PointsOfInterestType) {
        viewContext.createPointsOfInterestTypeEntity(type: type)
    }

    private func removeFromFavorite(type: PointsOfInterestType) {
        guard let savedEntity = favoritePOITypeEntity(from: type) else {
            print("Entity not found ! :(")
            return
        }

        viewContext.deletePointsOfInterestTypeEntity(savedEntity)
    }
}

#Preview {
    PointsOfInterestTypesPicker(
        selectedTypes: .constant(.init([.summit]))
    )
    .configureEnvironmentForPreview()
}
