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

                listDescription()

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
        .onDisappear {
            print("onDisappear")
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
        let isSelected = isSelected(type: type)
        let isFavorite = isFavorite(type: type)

        HStack {
            Label(
                title: { Text(type.title) },
                icon: {
                    Image(systemName: type.systemImage)
                        .foregroundStyle(isSelected ? type.color : .secondary)
                }
            )

            if isFavorite {
                Image(systemName: "star.circle")
                    .foregroundStyle(.yellow)
            }

            Spacer()

            if isSelected {
                Image(systemName: "eye")
            }
        }
        .swipeActions {
            if isFavorite {
                Button("remove_from_favorites", systemImage: "star.slash.fill", action: {
                    print("remove from favorites")
                    removeFromFavorite(type: type)
                })
                .foregroundStyle(.yellow)
                .tint(.systemBackground)
            } else {
                Button("add_to_favorites", systemImage: "star.fill", action: {
                    print("add to favorites")
                    addToFavorite(type: type)
                })
                .tint(.yellow)
            }
        }
    }

    private func isSelected(type: PointsOfInterestType) -> Bool {
        return localSelection.contains(type)
    }

    private func isFavorite(type: PointsOfInterestType) -> Bool {
        return defaultDisplayedTypes.contains(type)
    }

    private func addToFavorite(type: PointsOfInterestType) {
        do {
            _ = PointsOfInterestTypeEntity(context: viewContext, pointsOfInterestType: type)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func removeFromFavorite(type: PointsOfInterestType) {
        do {
            guard let savedEntity = savedPointsOfInterestsTypeEntity.first(where: { $0.id == type.id }) else {
                print("ouups??")
                return
            }
            viewContext.delete(savedEntity)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    PointsOfInterestTypesPicker(
        selectedTypes: .constant(.init([.summit]))
    ).environment(\.managedObjectContext, .previewViewContext)
}
