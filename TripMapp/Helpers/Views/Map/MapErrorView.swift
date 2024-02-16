//
//  MapErrorView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 19/02/2024.
//

import SwiftUI

struct MapErrorView: View {
    let error: Error
    let retryHandler: () -> Void

    var body: some View {
        HStack(spacing: 12.0) {
            Text(error.localizedDescription)
                .font(.caption)

            Button("Retry", action: retryHandler)
        }
        .borderShadow()
    }
}

#Preview {
    MapErrorView(error: NetworkError.invalidData, retryHandler: {})
}
