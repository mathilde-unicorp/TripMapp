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
                .foregroundStyle(.white)

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

    @ViewBuilder
    func onDelete(action: @escaping () -> Void) -> some View {
        HStack {
            self

            Spacer()

            Button {
                withAnimation { action() }
            } label: {
                Image(systemName: "minus")
                    .padding(8.0)
                    .background(.red)
                    .clipShape(Circle())
                    .foregroundStyle(.white)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    List {
        ImportedFileRow(name: "File 1", description: "GPX file from device")
            .onDelete { print("delete") }

        ImportedFileRow(name: "File 2")
    }
}
