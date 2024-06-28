//
//  PointOfInterestMapDisplayButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 28/06/2024.
//

import SwiftUI

struct ShowingOnMapButton: View {
    let isShowingOnMap: Bool

    var action: () -> Void

    private var buttonTitle: LocalizedStringKey {
        isShowingOnMap ? "hide_on_map" : "show_on_map"
    }

    private var buttonImage: String {
        isShowingOnMap ? "eye.slash" : "eye"
    }

    var body: some View {
        Button(buttonTitle, systemImage: buttonImage, action: action)
            .tint(.accentColor)
    }
}

#Preview {
    List {
        Menu("Click") {
            ShowingOnMapButton(isShowingOnMap: false, action: {})
        }

        Text("Long Press")
            .contextMenu {
                ShowingOnMapButton(isShowingOnMap: false, action: {})
            }

        Text("Swipe")
            .swipeActions {
                ShowingOnMapButton(isShowingOnMap: true, action: {})
            }
    }
}
