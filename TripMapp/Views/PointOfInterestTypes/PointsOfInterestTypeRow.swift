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
                Image(systemName: type.systemImage)
                    .foregroundStyle(labelImageColor)
            }

            if isFavorite {
                Image(systemName: "star.circle")
                    .foregroundStyle(.yellow)
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
    }
}
