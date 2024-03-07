//
//  TestLoadView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/02/2024.
//

import SwiftUI

struct AsyncActionView<Source: ActionableObject,
                    LoadingView: View,
                    Content: View>: View {

    @ObservedObject var source: Source

    var loadingView: LoadingView
    var content: (Source) -> Content

    init(
        source: Source,
        loadingView: LoadingView,
        @ViewBuilder content: @escaping (Source) -> Content
    ) {
        self.source = source
        self.loadingView = loadingView
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .idle, .loaded, .failed:
            content(source)
        case .loading:
            loadingView
        }
    }
}

#Preview {
    AsyncActionView(
        source: MockAction(),
        loadingView: ProgressView(),
        content: { source in
            Button("Tap on me") { source.action() }
                .buttonStyle(BorderedProminentButtonStyle())
        }
    )
}

class MockAction: ActionableObject {

    @Published var state: LoadingState<Void> = .idle

    func action() {
        self.state = .loading

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.state = .loaded(Void())
        }
    }
}
