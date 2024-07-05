//
//  MapSearchBarSizeSlider.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI

enum SearchBarSize {
    case reduced
    case medium
}

/// A slider with a DragGesture updating the searchBarSize depending on the user movements
struct MapSearchBarSizeSlider: View {
    @Binding var searchBarSize: SearchBarSize

    var sliderColor: Color = .quaternaryLabel

    @State private var hasChanged: Bool = false

    var body: some View {
        sliderColor
            .frame(width: 100, height: 5.0)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding(8.0)
            .setFullWidth(alignment: .center) // make the full width draggable
            .gesture(DragGesture()
                .onChanged { value in
                    // If the size has already changed, do not update it again
                    guard !hasChanged else { return }

                    withAnimation {
                        let isScrollingUp = value.translation.height < 0
                        let newSearchBarSize: SearchBarSize = isScrollingUp ? .medium : .reduced

                        if newSearchBarSize != searchBarSize {
                            self.searchBarSize = newSearchBarSize
                            self.hasChanged = true
                        }
                    }
                }
                .onEnded { _ in self.hasChanged = false }
            )
    }
}

#Preview {
    MapSearchBarSizeSlider(searchBarSize: .constant(.medium))
        .background(Color.secondarySystemBackground)
}
