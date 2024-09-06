//
//  TripPointTypesPicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/03/2024.
//

import SwiftUI
import CoreData

struct TripPointTypesSelectionView: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// Selected Trip Point Types on the picker
    @Binding var selectedTypes: [TripPointType]

    // -------------------------------------------------------------------------
    // MARK: - Swift Data
    // -------------------------------------------------------------------------

    /// Local data access
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        fetchRequest: TripPointTypeEntity.sortedFetchRequest(),
        transaction: .init(animation: .default)
    )
    private var favoritesTripPointTypes: FetchedResults<TripPointTypeEntity>

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    @Environment(\.dismiss) private var dismiss

    /// Local selection avoid the owner of `selectedType` property
    /// to be triggered every time the user change its selection on this view
    @State private var localSelectionForMapDisplay: [TripPointType]

    /// Single selection is used on the `List` to get notified when the user select an item
    @State private var listSingleSelection: Int?

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(selectedTypes: Binding<[TripPointType]>) {
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

                ForEach(TripPointType.Category.allCases) { category in
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
                   let type = TripPointType(rawValue: newSelection) {
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
        types: [TripPointType]
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
        type: TripPointType,
        isSelectedForMapDisplay: Bool,
        isFavorite: Bool
    ) -> some View {
        TripPointTypeRow(
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

    private func isSelectedForMapDisplay(type: TripPointType) -> Bool {
        return localSelectionForMapDisplay.contains(type)
    }

    private func isFavorite(type: TripPointType) -> Bool {
        return favoritesTripPointTypes.contains { $0.id == type.id }
    }

    private func favoriteTripPointTypeEntity(
        from type: TripPointType
    ) -> TripPointTypeEntity? {
        return favoritesTripPointTypes.first(where: { $0.id == type.id })
    }

    // -------------------------------------------------------------------------
    // MARK: - Database saving
    // -------------------------------------------------------------------------

    private func addToFavorite(type: TripPointType) {
        TripPointTypeEntity(context: viewContext)
            .setup(type: type)

        try? viewContext.save()
    }

    private func removeFromFavorite(type: TripPointType) {
        guard let savedEntity = favoriteTripPointTypeEntity(from: type) else {
            print("Entity not found ! :(")
            return
        }

        viewContext.delete(savedEntity)

        try? viewContext.save()
    }
}

#Preview {
    TripPointTypesSelectionView(
        selectedTypes: .constant(.init([.summit]))
    )
    .configureEnvironmentForPreview()
}
