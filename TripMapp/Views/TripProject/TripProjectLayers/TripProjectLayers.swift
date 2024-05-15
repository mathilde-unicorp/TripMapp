//
//  TripProjectLayers.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/04/2024.
//

import SwiftUI

struct TripProjectLayersView: View {
    let project: TripProject

    @Binding var isPresented: Bool

    @State private var isExpanded: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                LayersButton {
                    withAnimation { isPresented = false }
                }
                .padding(8.0)

                Spacer()

                Button("", systemImage: "ellipsis.circle") {
                    // additionnal informations
                }
            }

            List {
                ForEach(project.layers) { layer in
                    Section(isExpanded: $isExpanded) {
                        ForEach(layer.items, id: \.self) { item in
                            Label(item.description, systemImage: "arrow.triangle.swap")
                        }

                    } header: {
                        HStack {
                            Button {
                                withAnimation { isExpanded.toggle() }
                            } label: {
                                Text(layer.name)
                                Spacer()
                                Image(systemName: isExpanded ? "chevron.down" : "chevron.up")
                            }
                            .foregroundStyle(.primary)
                            .font(.headline)
                        }
                    }
                }
//                Section(isExpanded: $isExpanded) {
//                    Label("Road 1", systemImage: "arrow.triangle.swap")
//                    Label("Point 1", systemImage: "mappin")
//                    Label("Refuge 2", systemImage: "house.fill")
//                } header: {
//                }
            }
            .listStyle(.plain)
        }
        .background(.background)
    }
}

#Preview {
    TripProjectLayersView(
        project: TripProject(
            name: "Test",
            markers: [],
            traces: [],
            layers: [.init(name: "Layer 1", items: [UUID(), UUID()])]
        ),
        isPresented: .constant(true)
    )
}
