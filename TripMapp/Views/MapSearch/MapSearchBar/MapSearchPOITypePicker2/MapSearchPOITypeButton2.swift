//
//  MapSearchPOITypeButton2.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/07/2024.
//

import SwiftUI

struct MapSearchPOITypeButton2: View {
    let type: POIType
    let isSelectedForMapDisplay: Bool

    var action: () -> Void

    private var labelImageColor: Color {
        isSelectedForMapDisplay ? .white : .secondary
    }

    var body: some View {
        if isSelectedForMapDisplay {
            Button(action: action, label: buttonBody)
                .buttonStyle(.borderedProminent)
                .tint(type.color)
        } else {
            Button(action: action, label: buttonBody)
                .buttonStyle(.bordered)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func buttonBody() -> some View {
        Label {
            Text(type.title)
        } icon: {
            Image(systemName: type.systemImage)
                .foregroundStyle(labelImageColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack {
        MapSearchPOITypeButton2(type: .refuge, isSelectedForMapDisplay: true) {}
        MapSearchPOITypeButton2(type: .refuge, isSelectedForMapDisplay: false) {}
    }
}
