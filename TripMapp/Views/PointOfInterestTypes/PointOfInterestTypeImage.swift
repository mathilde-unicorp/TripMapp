//
//  TripPointTypeImage.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/07/2024.
//

import SwiftUI

struct TripPointTypeImage: View {
    let systemImage: String
    let title: LocalizedStringKey
    let selectedColor: Color
    let imageSize: CGFloat = 30.0

    var isSelected: Bool

    private var backgroundColor: Color {
        isSelected ? selectedColor : .systemBackground
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
        isSelected: Bool
    ) {
        self.systemImage = systemImage
        self.title = title
        self.selectedColor = selectedColor
        self.isSelected = isSelected
    }

    init(
        tripPointType: TripPointType,
        isSelected: Bool
    ) {
        self.systemImage = tripPointType.systemImage
        self.title = tripPointType.title
        self.selectedColor = tripPointType.color
        self.isSelected = isSelected
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Image(systemName: systemImage)
            .resizable()
            .scaledToFit()
            .frame(width: imageSize, height: imageSize)
            .padding(8.0)
            .clipToCircle(backgroundColor: backgroundColor)
            .foregroundStyle(imageColor)
    }
}

#Preview {
    VStack {
        TripPointTypeImage(tripPointType: .refuge, isSelected: false)
        TripPointTypeImage(tripPointType: .refuge, isSelected: true)
    }
    .padding()
    .background(Color.secondarySystemBackground)
    .clipShape(RoundedRectangle(cornerRadius: 20))
}
