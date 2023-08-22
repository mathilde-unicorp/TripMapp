//
//  RefugeList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI

struct RefugeList: View {

    let refugeType: RefugePointType?

    @EnvironmentObject var refugesInfoData: RefugesInfoData

    // MARK: State

    @State private var refuges: [RefugesInfo.Refuge]?
    @State private var isLoading: Bool = false
    @State private var hasError: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if let refuges = refuges {
                    List(refuges, id: \.properties.id) { refuge in
                        NavigationLink(destination: {
                            RefugeDetailView(id: refuge.properties.id.description)
                                .environmentObject(refugesInfoData)
                        }, label: {
                            RefugeCell(
                                name: refuge.properties.name,
                                image: refuge.properties.type.icon
                            )
                        })
                    }
                } else {
                    // loading refuges
                    ProgressView()
                }
            }.loadingTask(isLoading: $isLoading) {
                do {
                    self.refuges = try await refugesInfoData.loadRefuges(type: refugeType)
                } catch {
                    self.hasError = true
                }
            }
        }
    }
}

struct RefugeList_Previews: PreviewProvider {
    static var previews: some View {
        RefugeList(refugeType: .refuge)
            .environmentObject(RefugesInfoData())
    }
}
