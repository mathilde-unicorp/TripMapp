//
//  RefugeTitleView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import SwiftUI

struct RefugeTitleView: View {
    let icon: Image
    let title: String
    let placeID: Int

    var body: some View {
        HStack(spacing: 12.0) {
            VStack {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .foregroundColor(.green)

                Text("ID: \(placeID.description)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text(title)
                .font(.title)
                .fontWeight(.bold)

            Spacer()
        }
    }
}

struct RefugeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        RefugeTitleView(icon: Image(systemName: "tent"), title: "Mock Place", placeID: 1234)
    }
}
