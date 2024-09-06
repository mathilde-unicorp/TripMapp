//
//  LocalTripProjects.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/09/2024.
//

import SwiftUI

/// Local Trip Projects saved
struct LocalTripProjects<V: View>: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    var contentBuilder: (_ projects: FetchedResults<TripProjectEntity>) -> V

    // -------------------------------------------------------------------------
    // MARK: - Swift Data
    // -------------------------------------------------------------------------

    /// Local data access
    @Environment(\.managedObjectContext) private var viewContext

    /// List of user projects sorted by the one starting first then by name
    @FetchRequest(
        fetchRequest: TripProjectEntity.sortedFetchRequest(),
        transaction: .init(animation: .default)
    )
    private var projects: FetchedResults<TripProjectEntity>

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        contentBuilder(projects)
    }
}

#Preview {
    LocalTripProjects { projects in
        ForEach(projects) { project in
            TripProjectRow(project: project)
        }
    }
    .configureEnvironmentForPreview()
}
