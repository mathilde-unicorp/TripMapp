//
//  RefugesView+refugesList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI

struct RefugesList: View {

    let refuges: [RefugesInfo.LightRefugePoint]

    @EnvironmentObject var refugesInfoData: RefugesInfoData

    @State private var searchText: String = ""

    private var filteredRefuges: [RefugesInfo.LightRefugePoint] {
        if searchText.isEmpty {
            return refuges
        }

        return refuges.filter {
            $0.properties.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var annotationItems: [AnnotationItem] {
        return filteredRefuges.map { refuge in
            AnnotationItem(
                coordinate: refuge.geometry.coordinated2D,
                title: refuge.properties.name,
                image: refuge.properties.type.icon
            )
        }
    }

    var body: some View {
        VStack {
            MapView(
                coordinate: filteredRefuges.first?.geometry.coordinated2D ?? .init(latitude: 0.0, longitude: 0.0),
                span: 1.0,
                annotationItems: annotationItems
            )
            .frame(height: 400)

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
            .listStyle(.plain)
            .searchable(text: $searchText)
            .overlay {
                if filteredRefuges.isEmpty {
                    Text("Sorry, no result found.")
                        .font(.headline)
                }
            }
        }
    }
}

struct RefugesView_refugesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RefugesList(refuges: MockRefugesInfoData().refuges.map(\.toLightPoint))
            .environmentObject(RefugesInfoData())
        }
    }
}
