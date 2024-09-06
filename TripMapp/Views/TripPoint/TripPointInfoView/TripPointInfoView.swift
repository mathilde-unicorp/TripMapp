//
//  TripPointInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/09/2024.
//

import SwiftUI

//
struct TripPointInfoView: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// A trip point the user want to add in a project
    let tripPoint: TripPoint?

    // -------------------------------------------------------------------------
    // MARK: - Swift Data
    // -------------------------------------------------------------------------

    /// Local data access
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        fetchRequest: <#expected fetch request#>,
//        transaction: .init(animation: .default)
//    )
//    private var result FetchedResults<<#ResultType#>>

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

//    @State private var localState: <#Type#>?

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        EmptyView()
    }
}

#Preview {
    TripPointInfoView(tripPoint: .mocks.first)
}
