//
//  PointsOfInterestTypeRow.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 28/06/2024.
//

import SwiftUI

struct PointsOfInterestTypeRow: View {
    let type: POIType
    let isFavorite: Bool
    let isSelectedForMapDisplay: Bool

    private var labelImageColor: Color {
        isSelectedForMapDisplay ? type.color : .secondary
    }

    var body: some View {
        HStack {
            Label {
                Text(type.title)
            } icon: {
                PointOfInterestTypeImage(
                    poiType: type,
                    isSelected: isSelectedForMapDisplay
                )
                .overlay(alignment: .bottomTrailing) {
                    if isFavorite {
                        Image(systemName: "star.circle")
                            .foregroundStyle(Color.yellow)
                            .clipToCircle(backgroundColor: .systemGroupedBackground)
                            .padding(-8)
                    }
                }
            }

            Spacer()

            if isSelectedForMapDisplay {
                Image(systemName: "eye")
            }
        }
    }
}

#Preview {
    List {
        PointsOfInterestTypeRow(
            type: .refuge,
            isFavorite: true,
            isSelectedForMapDisplay: true
        )

        PointsOfInterestTypeRow(
            type: .bivouac,
            isFavorite: true,
            isSelectedForMapDisplay: false
        )

        PointsOfInterestTypeRow(
            type: .hotel,
            isFavorite: false,
            isSelectedForMapDisplay: false
        )
    }
}
