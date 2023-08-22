//
//  Loader.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import SwiftUI

struct Loader<V: View>: ViewModifier {

    @State var isLoading: Bool

    @ViewBuilder var loadingView: () -> V

    func body(content: Content) -> some View {
        if isLoading {
            loadingView()
        } else {
            content
        }
    }
}

extension View {
    func loader<V: View>(isLoading: Bool, loadingView: @escaping () -> V) -> some View {
        return modifier(Loader(isLoading: isLoading, loadingView: loadingView))
    }

    func progressLoader(isLoading: Bool) -> some View {
        return modifier(Loader(isLoading: isLoading, loadingView: { ProgressView() }))
    }

    func rectangleLoader(isLoading: Bool, estimatedHeight: CGFloat = 40.0) -> some View {
        return modifier(Loader(isLoading: isLoading, loadingView: {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color(UIColor.secondarySystemBackground))
                .frame(height: estimatedHeight)
                .overlay { ProgressView() }
        }))
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, world !")
                .progressLoader(isLoading: true)
                .padding()

            Text("Hello, world !")
                .rectangleLoader(isLoading: true)
                .padding()
        }
    }
}
