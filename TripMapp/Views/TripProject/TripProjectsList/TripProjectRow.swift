//
//  TripProjectsList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import SwiftUI

struct TripProjectRow: View {

    let project: TripProject

    var body: some View {
        HStack {
            Image("ProjectImagePlaceholder")
                .resizable()
                .frame(width: 60, height: 60)
                .scaledToFill()
                .clipped()

            VStack(alignment: .leading) {
                Text(project.name)
                    .font(.body)

                if let startDate = project.startDate {
                    Text(startDate.formatted())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    List {
        TripProjectRow(project: .init(name: "Test Project", startDate: .now))
    }
}
