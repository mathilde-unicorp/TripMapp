//
//  AccomodationsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/02/2024.
//

import SwiftUI

extension RefugeDescriptionView {
    struct EquipmentsView: View {
        private let cellSize: CGFloat = 24.0
        private let expectedEquipments: [RefugeEquipment] = RefugeEquipment.allCases

        private let presentEquipments: [RefugeEquipment]
        private let absentEquipments: [RefugeEquipment]

        init(accomodations: [RefugeEquipment]) {
            self.presentEquipments = expectedEquipments.filter { accomodation in
                accomodations.contains(accomodation)
            }
            self.absentEquipments = expectedEquipments.filter { accomodation in
                !accomodations.contains(accomodation)
            }
        }

        init(viewModel: ViewModel) {
            self.init(
                accomodations: viewModel.equipments
            )
        }

        // ---------------------------------------------------------------------
        // MARK: - Body
        // ---------------------------------------------------------------------

        var body: some View {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(presentEquipments, id: \.rawValue) { accomodation in
                        equipmentItem(accomodation, isPresent: true)
                    }

                    ForEach(absentEquipments, id: \.rawValue) { accomodation in
                        equipmentItem(accomodation, isPresent: false)
                    }
                }
            }
        }

        @ViewBuilder
        private func equipmentItem(_ accomodation: RefugeEquipment, isPresent: Bool) -> some View {
            VStack {
                Image(systemName: accomodation.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: cellSize, height: cellSize)

                Text(accomodation.title)
                    .font(.caption)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(width: cellSize * 4, height: cellSize * 3)
            .background(isPresent ? accomodation.presentColor : Color.secondarySystemBackground)
            .bold(isPresent)
            .opacity(isPresent ? 1.0 : 0.7)
        }
    }
}

#Preview {
    RefugeDescriptionView.EquipmentsView(
        accomodations: [
            //        .fireplace,
            //        .blankets,
            .missingWall,
            .stove,
            //        .toilets,
            .water,
            .wood
        ])
}
