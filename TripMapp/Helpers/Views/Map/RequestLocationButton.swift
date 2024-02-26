//
//  RequestLocationButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/02/2024.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct RequestLocationButton: View {

    var action: () -> Void

    var body: some View {
        LocationButton(.currentLocation, action: action)
            .clipShape(Circle())
            .labelStyle(.iconOnly)
            .foregroundStyle(Color.systemBackground)
            .padding()
    }
}

#Preview {
    RequestLocationButton() {}
}
