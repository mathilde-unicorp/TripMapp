//
//  TripMapLayersPanel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/08/2024.
//

import SwiftUI
import MapKit

struct TripLayersPanel: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    @ObservedObject var projectEntity: TripProjectEntity

    @Binding var selectedItemId: String?

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    @State private var showSidebar: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

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
                    selectedItemId: $selectedItemId,
                    project: projectEntity
                )
                .frame(width: 300)

                // TODO: only on small portrait mode
                UIColor.systemBackground.withAlphaComponent(0.4).swiftUiColor
                    .ignoresSafeArea(edges: .all)
                    .onTapGesture {
                        withAnimation { showSidebar = false }
                    }
            }
        }
    }
}

#Preview {
    Map {

    }
    .overlay(alignment: .topLeading) {
        TripLayersPanel(
            projectEntity: .previewExample,
            selectedItemId: .constant(nil)
        )
    }
}
