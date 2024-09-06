//
//  TripPointTypeLabel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 11/07/2024.
//

import SwiftUI

struct TripPointTypeLabel: View {
    
    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------
    
    private let systemImage: String
    private let title: LocalizedStringKey
    private let selectedColor: Color
    private let imageSize: CGFloat = 30.0

    private let isSelected: Bool

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

        .frame(width: 60)
    }
}

#Preview {
    HStack {
        TripPointTypeLabel(tripPointType: .refuge, isSelected: true)
        TripPointTypeLabel(tripPointType: .foodstuffProvisions, isSelected: false)
        TripPointTypeLabel(tripPointType: .sportsProvisions, isSelected: false)
    }
}
