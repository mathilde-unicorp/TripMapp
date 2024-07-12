//
//  TripProjectLayers.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/04/2024.
//

import SwiftUI

struct TripProjectLayersView: View {

    @Binding var isPresented: Bool

    @ObservedObject private var project: TripProjectEntity

    @Environment(\.managedObjectContext) private var viewContext

    @State private var points: [TripPointEntity] = []

    init(isPresented: Binding<Bool>, project: TripProjectEntity) {
        self._isPresented = isPresented
        self.project = project
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                LayersButton {
                    withAnimation { isPresented = false }
                }

                Spacer()

                EditButton()
            }
            .padding(8.0)

            List {
                ForEach(points, id: \.id) { item in
                    pointRow(item)
                }
                .onDelete { deleteItems(offsets: $0) }
                .onMove { moveItems(fromOffsets: $0, toOffset: $1) }
            }
            .listStyle(.plain)
        }
        .background(.background)
        .onAppear {
            self.points = self.project.points
        }
        .onChange(of: project.points) { _, newValue in
            self.points = newValue
        }
    }

    @ViewBuilder
    private func pointRow(_ item: TripPointEntity) -> some View {
        Label(
            item.name ?? "--",
            systemImage: item.tripPointType?.systemImage ?? "mappin"
        )
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { points[$0] }
                .forEach { viewContext.delete($0) }

            try? viewContext.save()
        }
    }

    private func moveItems(
        fromOffsets source: IndexSet,
        toOffset destination: Int
    ) {
        var currentPoints = self.points

        currentPoints.move(fromOffsets: source, toOffset: destination)

        project.points.forEach { point in
            let index = currentPoints.firstIndex(of: point)!
            point.update(position: Int16(index))
        }

        try? viewContext.save()
        self.points = project.points
    }
}

// =============================================================================
// MARK: - Preview
// =============================================================================

#Preview {
    TripProjectLayersView(
        isPresented: .constant(true),
        project: .previewExample
    )
    .configureEnvironmentForPreview()
}
