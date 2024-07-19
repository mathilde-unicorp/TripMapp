//
//  TripMapLayersPanel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/08/2024.
//

import SwiftUI

struct TripLayersPanel: View {

    let projectEntity: TripProjectEntity

    @State private var showSidebar: Bool = false

    var body: some View {
        if !showSidebar {
            LayersButton {
                withAnimation { showSidebar = true }
            }
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 6.0))
            .shadow(radius: 4)
            .padding(8.0)
        } else {
            HStack(spacing: 0) {
                TripProjectLayersView(
                    isPresented: $showSidebar,
                    project: projectEntity
                )
                .frame(width: 300)

                // TODO: only on small portrait mode
                UIColor.systemBackground.withAlphaComponent(0.4).swiftUiColor
                    .onTapGesture {
                        withAnimation { showSidebar = false }
                    }
            }
        }
    }
}

#Preview {
    Text("MyMap")
        .overlay(alignment: .topLeading) {
            TripLayersPanel(projectEntity: .previewExample)
        }
}
