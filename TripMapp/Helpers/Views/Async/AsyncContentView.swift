//
//  AsyncContentView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/01/2024.
//

import SwiftUI

struct AsyncContentView<Source: LoadableObject,
                        LoadingView: View,
                        Content: View>: View {
    @ObservedObject var source: Source

    var loadingView: LoadingView
    var content: (Source.Output) -> Content

    init(
        source: Source,
        loadingView: LoadingView,
        @ViewBuilder content: @escaping (Source.Output) -> Content
    ) {
        self.source = source
        self.loadingView = loadingView
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            loadingView
        case .failed(let error):
            DefaultErrorView(error: error, retryHandler: source.load)
        case .loaded(let output):
            content(output)
        }
    }
}

// =============================================================================
// MARK: - Preview
// =============================================================================

#Preview {
    VStack {
        AsyncContentView(
            source: MockSource(),
            loadingView: ProgressView(),
            content: { result in
                VStack {
                    Text("\(result)")
                }
            })
    }
}

private class MockSource: LoadableObject {
    @Published var state: LoadingState<String> = .idle

    func load() {
        self.state = .loading

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            self.state = .loaded("OK !")
            self.state = .failed(NSError(domain: "", code: -1))
        }
    }
}
