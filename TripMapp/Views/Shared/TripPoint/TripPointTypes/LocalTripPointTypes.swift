//
//  LocalTripPointTypes.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/09/2024.
//

import SwiftUI

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
    private var favoritesTripPointTypes: FetchedResults<TripPointTypeEntity>

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        contentBuilder(favoritesTripPointTypes)
    }
}

#Preview {
    List {
        LocalTripPointTypes { types in
            ForEach(types) { type in
                if let tripPointType = type.tripPointType {
                    TripPointTypeRow(
                        type: tripPointType,
                        isFavorite: false,
                        isSelectedForMapDisplay: false
                    )
                }
            }
        }
    }
        .configureEnvironmentForPreview()
}
