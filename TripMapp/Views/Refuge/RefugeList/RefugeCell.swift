//
//  RefugeCell.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//
import SwiftUI

struct RefugeCell: View {
    let name: String
    let image: Image

    var body: some View {
        HStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20.0)

            Text(name)
        }
    }
}

struct RefugeCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RefugeCell(name: "Home", image: Image(systemName: "house"))

        }
    }
}
