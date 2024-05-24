//
//  ImageButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct ImageButton: View {
    var systemImage: String
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemImage)
                .foregroundStyle(.white)
                .padding()
                .background(.blue)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ImageButton(systemImage: "photo.fill", action: {})
}
