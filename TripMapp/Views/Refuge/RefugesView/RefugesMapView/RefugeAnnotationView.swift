//
//  RefugeAnnotation.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import SwiftUI
import MapKit

// -------------------------------------------------------------------------
// MARK: - View
// -------------------------------------------------------------------------

struct RefugeAnnotationView: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .padding(8)
            .background(Color.systemBackground)
            .cornerRadius(8)
            .foregroundColor(.green)
            .shadow(radius: 4) // Add a subtle shadow
    }
}

#Preview {
    RefugeAnnotationView(
        image: Image(systemName: "tent")
    )
}
