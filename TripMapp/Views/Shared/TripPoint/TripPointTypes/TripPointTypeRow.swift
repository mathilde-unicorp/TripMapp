//
//  TripPointTypeRow.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 28/06/2024.
//

import SwiftUI

struct TripPointTypeRow: View {
    
    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    let type: TripPointType
    let isFavorite: Bool
    let isSelectedForMapDisplay: Bool

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    private var labelImageColor: Color {
        isSelectedForMapDisplay ? type.color : .secondary
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        HStack {
            Label {
                Text(type.title)
            } icon: {
                TripPointTypeImage(
                    tripPointType: type,
                    isSelected: isSelectedForMapDisplay
                )
                .overlay(alignment: .bottomTrailing) {
                    if isFavorite {
                        Image(systemName: "star.circle")
                            .foregroundStyle(Color.yellow)
                            .clipToCircle(backgroundColor: .systemBackground)
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
        TripPointTypeRow(
            type: .refuge,
            isFavorite: true,
            isSelectedForMapDisplay: true
        )

        TripPointTypeRow(
            type: .bivouac,
            isFavorite: true,
            isSelectedForMapDisplay: false
        )

        TripPointTypeRow(
            type: .hotel,
            isFavorite: false,
            isSelectedForMapDisplay: false
        )
    }
}
