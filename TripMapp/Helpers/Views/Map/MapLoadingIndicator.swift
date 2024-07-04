//
//  MapLoadingIndicator.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/07/2024.
//

import SwiftUI
import MapKit

struct MapLoadingIndicator<Value>: View {
    @Binding var loadingState: LoadingState<Value>

    var body: some View {
        if loadingState == .loading {
            ProgressView()
                .progressViewStyle(.circular)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .padding(10.0)
        }
    }
}

#Preview {
    Map {

    }.overlay(alignment: .top) {
        MapLoadingIndicator<String>(loadingState: .constant(.loading))
    }
}
