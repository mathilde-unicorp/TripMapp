//
//  ImportFileRow.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct ImportFileRow: View {
    var body: some View {
        HStack {
            Image(systemName: "plus")
                .padding()
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))

            VStack(alignment: .leading) {
                Text("add_a_file")
                    .font(.headline)

                Text("add_a_file_description")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ImportFileRow()
}
