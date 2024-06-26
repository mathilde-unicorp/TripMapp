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
            }
            .padding(8.0)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
        .foregroundStyle(.secondary)
    }
}

#Preview {
    SearchBarButton(placeholder: "map_search_bar.placeholder") {
        print("tap search bar")
    }
}
