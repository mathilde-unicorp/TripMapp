//
//  SearchBarButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/06/2024.
//

import SwiftUI

struct SearchBarButton: View {
    var placeholder: LocalizedStringKey
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: "magnifyingglass")

                Text(placeholder)
                    .setFullWidth()
                    .lineLimit(1)
            }
            .padding(8.0)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
        .foregroundStyle(.secondary)
    }
}

#Preview {
    SearchBarButton(placeholder: "map_search_bar.placeholder") {
        print("tap search bar")
    }
    .padding()
    .background(.thickMaterial)
}
