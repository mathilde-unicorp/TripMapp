//
//  RefugesView+refugesList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI

struct RefugesList: View {

    let refuges: [RefugesInfo.Refuge]

    @EnvironmentObject var refugesInfoData: RefugesInfoData

    @State private var searchText: String = ""

    private var filteredRefuges: [RefugesInfo.Refuge] {
        if searchText.isEmpty {
            return refuges
        }

        return refuges.filter {
            $0.properties.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        List(filteredRefuges, id: \.properties.id) { refuge in
            NavigationLink(destination: {
                RefugeDetailView(pointId: refuge.properties.id)
                    .environmentObject(refugesInfoData)
            }, label: {
                RefugeCell(
                    name: refuge.properties.name,
                    image: refuge.properties.type.icon
                )
            })
        }
        .searchable(text: $searchText)
        .overlay {
            if filteredRefuges.isEmpty {
                Text("Sorry, no result found.")
                    .font(.headline)
            }
        }
    }
}

struct RefugesView_refugesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RefugesList(refuges: [
                .init(properties: .init(id: 4889, name: "Refuge", type: .refuge),
                      geometry: .init(coordinates: [0, 0]))
            ])
            .environmentObject(RefugesInfoData())
        }
    }
}
