//
//  MapSearchPOIButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/06/2024.
//

import SwiftUI

struct MapSearchPOITypeButton: View {
    let systemImage: String
    let title: LocalizedStringKey
    let selectedColor: Color
    let imageSize: CGFloat = 30.0

    var isSelected: Bool

    let action: () -> Void

    private var backgroundColor: Color {
        isSelected ? selectedColor : .secondarySystemBackground
    }

    private var imageColor: Color {
        isSelected ? .white : UIColor.secondaryLabel.swiftUiColor
    }

    private var textColor: Color {
        isSelected ? .label : .secondaryLabel
    }

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(
        systemImage: String,
        title: LocalizedStringKey,
        selectedColor: Color,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.systemImage = systemImage
        self.title = title
        self.selectedColor = selectedColor
        self.isSelected = isSelected
        self.action = action
    }

    init(
        poiType: POIType,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.systemImage = poiType.systemImage
        self.title = poiType.title
        self.selectedColor = poiType.color
        self.isSelected = isSelected
        self.action = action
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .center) {
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
                    .padding(16.0)
                    .clipToCircle(backgroundColor: backgroundColor)
                    .foregroundStyle(imageColor)

                Text(title)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(textColor)
                    .font(.caption)
            }
        }
        .frame(width: 60)
    }

}

// =============================================================================
// MARK: - Preview
// =============================================================================

#Preview {
    VStack {
        MapSearchPOITypeButton(
            poiType: .refuge,
            isSelected: false
        ) {
            print("Select 1")
        }

        MapSearchPOITypeButton(
            poiType: .bivouac,
            isSelected: false
        ) {
            print("Select 2")
        }
    }
}
