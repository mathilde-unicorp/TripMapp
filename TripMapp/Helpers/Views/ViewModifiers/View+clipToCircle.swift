//
//  ImageButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

extension View {
    func clipToCircle(backgroundColor: Color) -> some View {
        return self
            .background(backgroundColor)
            .clipShape(Circle())
    }
}

#Preview {
    VStack {
        Image(systemName: "photo.fill")
            .clipToCircle(backgroundColor: .blue)
            .foregroundStyle(.white)
    }
}
