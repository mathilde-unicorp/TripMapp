//
//  AsyncMapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/02/2024.
//

import SwiftUI
import MapKit

struct AsyncMapView<Source: LoadableMapObject,
                    LoadingView: View,
                    Content: MapContent>: View {
    @ObservedObject var source: Source

    var loadingView: LoadingView

    @MapContentBuilder
    var mapContent: (Source.Output) -> Content

    @State private var shouldShowSearchButton: Bool = false
    @State private var savedOutput: Source.Output?

    init(
        source: Source,
        loadingView: LoadingView,
        @MapContentBuilder mapContent: @escaping (Source.Output) -> Content
    ) {
        self.source = source
        self.loadingView = loadingView
        self.mapContent = mapContent
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        ZStack(alignment: .top) {
            Map(
                position: $source.mapCameraPosition,
                selection: $source.selectedItem
            ) {
                if let annotations = savedOutput {
                    mapContent(annotations)
                }
            }
            .mapStyle(.hybrid)

            switch source.state {
            case .idle, .loaded:
                if shouldShowSearchButton {
                    MapSearchButton(action: loadMapContent)
                }
            case .loading:
                loadingView
            case .failed(let error):
                MapErrorView(error: error, retryHandler: loadMapContent)
            }
        }
        .onMapCameraChange { mapCamera in
            source.mapCameraPosition = .region(mapCamera.region)
            showSearchButton(withDelay: 2.0)
        }
        .onChange(of: source.state) { _, newState in
            if case .loaded(let values) = newState {
                self.savedOutput = values
            }
        }
        .onAppear { loadMapContent() }
    }

    private func loadMapContent() {
        withAnimation { self.shouldShowSearchButton = false }
        self.source.load()
    }

    private func showSearchButton(withDelay delay: TimeInterval) {
        if case .loading = source.state { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation { self.shouldShowSearchButton = true }
        }
    }
}

#Preview {
    AsyncMapView(
        source: MockMapLoadableViewModel(),
        loadingView: MapProgressView()
    ) { items in
        ForEach(items, id: \.id) { item in
            Annotation(item.name, coordinate: item.coordinates, content: {
                RefugeAnnotationView(image: item.image)
            })
        }
    }
}

// =============================================================================
// MARK: - Mock ViewModel
// =============================================================================


class MockMapLoadableViewModel: LoadableMapObject { 

    @Published var state: LoadingState<[MapAnnotationModel]> = .idle
    @Published var mapCameraPosition: MapCameraPosition = .region(
        .init(center: .france,
              span: .init(latitudeDelta: 10.0, longitudeDelta: 10.0))
    )
    @Published var selectedItem: Int?

    @MainActor
    func load() {
        withAnimation {
            state = .loading
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            withAnimation {
                self.state = .loaded([
                    .init(id: 0, name: "Test 1", coordinates: .cabaneClartan, image: Image(systemName: "tent")),
                    .init(id: 1, name: "Test 2", coordinates: .giteDeLaColleStMichel, image: Image(systemName: "tent"))
                ])
//                self.state = .failed(NetworkError.invalidData)
            }
        }
    }
    

}
