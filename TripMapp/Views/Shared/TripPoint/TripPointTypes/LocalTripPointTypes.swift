//
//  LocalTripPointTypes.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/09/2024.
//

import SwiftUI

/// UI element containing the list of Trip Point Types saved by the user
struct LocalTripPointTypes<V: View>: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    var contentBuilder: (_ tripPointTypes: FetchedResults<TripPointTypeEntity>) -> V

    // -------------------------------------------------------------------------
    // MARK: - Swift Data
    // -------------------------------------------------------------------------

    /// Local data access
    @Environment(\.managedObjectContext) private var viewContext

    /// Fetch saved trip point types
    @FetchRequest(
        fetchRequest: TripPointTypeEntity.sortedFetchRequest(),
        transaction: .init(animation: .default)
    )
    private var tripPointTypes: FetchedResults<TripPointTypeEntity>

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        contentBuilder(tripPointTypes)
    }
}

#Preview {
    List {
        LocalTripPointTypes { types in
            ForEach(types.compactMap(\.tripPointType)) { type in
                TripPointTypeRow(
                    type: type,
                    isFavorite: false,
                    isSelectedForMapDisplay: false
                )
            }
        }
    }
        .configureEnvironmentForPreview()
}
