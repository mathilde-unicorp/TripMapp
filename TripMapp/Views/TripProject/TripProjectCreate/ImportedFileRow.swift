//
//  ImportedFileCell.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct ImportedFileRow: View {
    let name: String
    let description: String?

    init(name: String, description: String? = nil) {
        self.name = name
        self.description = description
    }

    var body: some View {
        HStack {
            Image(systemName: "arrow.triangle.swap")
                .padding(8.0)
                .background(.blue)
                .clipShape(Circle())
                .foregroundStyle(.background)

            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)

                if let description {
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    List {
        ImportedFileRow(name: "File 1", description: "GPX file from device")
        ImportedFileRow(name: "File 2")
    }
}
