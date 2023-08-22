//
//  RefugeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import SwiftUI

/**
 A view that displays detailed information about a refuge.

 Use this view to show specific details about a refuge, such as its name, location, description, and contact information.

 Example usage:
 ```
 let refugeDetail = RefugeDetailView(id: "refugeId")
     .environmentObject(RefugesInfoData())
 ```
 */
struct RefugeDetailView: View {

    // MARK: - Properties

    // MARK: View Parameters

    /// Point id on refuges info database
    var id: String

    @EnvironmentObject var refugesInfoData: RefugesInfoData

    // MARK: State

    @State private var refuge: RefugesInfo.Refuge?
    @State private var hasError: Bool = false
    @State private var isLoading: Bool = true

    // MARK: - Body

    var body: some View {
        VStack {
            if let refuge = refuge {
                RefugeDetailView.refugeDescriptionView(refuge)
            } else {
                RefugeDetailView.refugeLoadingView(isLoading: isLoading)
                    .banner(isPresented: $hasError, text: "Cannot load content :(", type: .error)
            }
        }
        .loadingTask(isLoading: $isLoading) {
            do {
                self.refuge = try await refugesInfoData.loadRefuge(id: id)
            } catch {
                self.hasError = true
            }
        }
    }
}


struct RefugeView_Previews: PreviewProvider {
    static var previews: some View {
        RefugeDetailView(id: "4889")
            .environmentObject(RefugesInfoData())
    }
}
