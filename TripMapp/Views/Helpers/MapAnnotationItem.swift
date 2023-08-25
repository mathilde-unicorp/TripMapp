//
//  MapAnnotationItem.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import SwiftUI
import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let image: Image
}

struct MapAnnotationItem: View {
    let item: AnnotationItem

    private let imageSize = 20.0

    var body: some View {
        VStack(spacing: 12.0) {
            item.image
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
        }
        .padding(8)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(8)
        .foregroundColor(.green)
        .shadow(radius: 4) // Add a subtle shadow
    }
}

struct MapAnnotationItem_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationItem(item: .init(
            coordinate: .init(latitude: 0.0, longitude: 0.0),
            title: "Title",
            image: Image(systemName: "tent")
        ))
    }
}
