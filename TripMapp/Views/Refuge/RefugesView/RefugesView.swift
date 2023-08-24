//
//  RefugeList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI

struct RefugesView: View {

    /// Type of refuges to load. If null, load all types.
    let refugeType: RefugesInfo.PointType?

    @EnvironmentObject var refugesInfoData: RefugesInfoData

    // MARK: State

    @State private var refuges: [RefugesInfo.LightRefugePoint]?
    @State private var isLoading: Bool = true
    @State private var hasError: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if let refuges = refuges {
                    RefugesList(refuges: refuges)
                } else {
                    refugesListLoading(isLoading: isLoading)
                }
            }
            .loadingTask(isLoading: $isLoading) {
                do {
                    self.refuges = try await refugesInfoData.loadRefuges(type: refugeType)
                } catch {
                    self.hasError = true
                }
            }
            .navigationTitle(refugeType?.value.capitalized ?? "All")
        }
    }

    @ViewBuilder
    func refugesListLoading(isLoading: Bool) -> some View {
        if isLoading {
            ProgressView()
        }
    }

}

struct RefugeList_Previews: PreviewProvider {
    static var previews: some View {
        RefugesView(refugeType: .refuge)
            .environmentObject(RefugesInfoData())
    }
}
