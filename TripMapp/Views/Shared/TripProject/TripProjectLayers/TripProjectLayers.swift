//
//  TripProjectLayers.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/04/2024.
//

import SwiftUI

struct TripProjectLayersView: View {

    @Binding var isPresented: Bool
    @Binding var selectedItemId: String?

    @ObservedObject var project: TripProjectEntity

    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private Properties
    // -------------------------------------------------------------------------

    @State private var points: [TripPointEntity] = []

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        VStack(alignment: .leading) {
            customToolbar()

            List {
                Section("points") {
                    ForEach(points, id: \.self) { item in
                        pointRow(item)
                    }
                    .onDelete { deleteItems(offsets: $0) }
                    .onMove { moveItems(fromOffsets: $0, toOffset: $1) }
                }
            }
            .listStyle(.plain)
        }
        .background(.background)
        .onAppear {
            self.points = self.project.points
        }
    }

    @ViewBuilder
    private func customToolbar() -> some View {
        HStack {
            LayersButton {
                withAnimation { isPresented = false }
            }

            Spacer()

            EditButton()
        }
        .padding(8.0)
    }

    @ViewBuilder
    private func pointRow(_ item: TripPointEntity) -> some View {
        Button(action: {
            withAnimation {
                selectedItemId = item.id?.uuidString
            }
        }, label: {
            Label(
                item.name ?? "--",
                systemImage: item.tripPointType?.systemImage ?? "mappin"
            )
        })
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let deletePoints = offsets.map { points[$0] }
            deletePoints.forEach { viewContext.delete($0) }

            // Update project points position with the new points position after deletion
            project.points.enumerated().forEach { index, point in
                point.update(position: Int16(index))
            }

            try? viewContext.save()
            self.points = project.points
        }
    }

    private func moveItems(
        fromOffsets source: IndexSet,
        toOffset destination: Int
    ) {
        var currentPoints = self.points
        currentPoints.move(fromOffsets: source, toOffset: destination)

        // Update project points position with the new moved positions
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

struct TripProjectLayersView_Previews: PreviewProvider {

    // A view which will wraps the actual view and holds state variable.
    struct ContainerView: View {
        @State private var isPresented: Bool = true
        @State private var selectedItemId: String?

        var body: some View {
            VStack {
                Text("Selected point id: \(selectedItemId ?? "nil")")

                Divider()

                TripProjectLayersView(
                    isPresented: .constant(true),
                    selectedItemId: $selectedItemId,
                    project: .previewExample
                )
            }
            .configureEnvironmentForPreview()
        }
    }

    static var previews: some View {
        ContainerView()
            .configureEnvironmentForPreview()
    }
}
