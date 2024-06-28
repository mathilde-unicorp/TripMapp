//
//  FavoriteButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 28/06/2024.
//

import SwiftUI

struct FavoriteButton: View {
    let isFavorite: Bool

    let action: () -> Void

    private var buttonTitle: LocalizedStringKey {
        isFavorite ? "remove_from_favorites" : "add_to_favorites"
    }

    private var buttonImage: String {
        isFavorite ? "star.slash" : "star.fill"
    }

    var body: some View {
        Button(buttonTitle, systemImage: buttonImage, action: action)
//            .foregroundStyle(.yellow)
            .tint(.yellow)
    }
}

#Preview {
    List {
        Menu("Click Me") {
            FavoriteButton(isFavorite: true, action: {})
        }

        Text("Long Press Me")
            .contextMenu {
                FavoriteButton(isFavorite: true, action: {})
            }

        Text("Swipe Me")
            .swipeActions {
                FavoriteButton(isFavorite: true, action: {})
            }
    }
}
