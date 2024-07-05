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
            .tint(.yellow)
    }
}

#Preview {
    List {
        Menu("_example_tap_on_me") {
            FavoriteButton(isFavorite: true, action: {})
        }

        Text("_example_long_press_me")
            .contextMenu {
                FavoriteButton(isFavorite: true, action: {})
            }

        Text("_example_swipe_me")
            .swipeActions {
                FavoriteButton(isFavorite: true, action: {})
            }
    }
}
