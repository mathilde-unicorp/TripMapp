//
//  RefugeDescriptionView.CapacityView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/02/2024.
//

import SwiftUI

extension RefugeDescriptionView {
    struct CapacityView: View {

        private let cellSize: CGFloat = 24.0
        private let places: Int?
        private let mattressPlaces: Int?

        init(places: Int?, mattressPlaces: Int?) {
            self.places = places
            self.mattressPlaces = mattressPlaces
        }

        init(viewModel: ViewModel) {
            self.places = viewModel.places
            self.mattressPlaces = viewModel.mattressPlaces
        }

        // ---------------------------------------------------------------------
        // MARK: - Body
        // ---------------------------------------------------------------------

        var body: some View {
            VStack {

                capacityItem(
                    imageSystemName: "person.2",
                    text: "Places prévues pour dormir",
                    value: places
                )

                if let mattressPlaces = mattressPlaces {
                    Divider()

                    capacityItem(
                        imageSystemName: "bed.double",
                        text: "Places sur matelas",
                        value: mattressPlaces
                    )
                }
            }
            .padding()
            .background(Color.secondarySystemGroupedBackground)
        }

        @ViewBuilder
        private func capacityItem(imageSystemName: String, text: String, value: Int?) -> some View {
            HStack {
                Image(systemName: imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: cellSize, height: cellSize)

                Text(text)
                    .font(.caption)

                Spacer()

                Text("\(value?.toString ?? "Non spécifié")")
                    .font(.headline)
            }
        }

    }
}
#Preview {
    RefugeDescriptionView.CapacityView(places: nil, mattressPlaces: 3)
}
