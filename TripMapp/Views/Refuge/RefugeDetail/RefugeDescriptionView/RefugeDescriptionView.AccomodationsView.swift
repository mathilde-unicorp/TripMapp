//
//  AccomodationsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/02/2024.
//

import SwiftUI

extension RefugeDescriptionView {
    struct AccomodationsView: View {
        private let cellSize: CGFloat = 24.0
        private let expectedAccomodations: [RefugeAccomodation] = RefugeAccomodation.allCases

        private let presentAccomodations: [RefugeAccomodation]
        private let absentAccomodations: [RefugeAccomodation]

        init(accomodations: [RefugeAccomodation]) {
            self.presentAccomodations = expectedAccomodations.filter { accomodation in
                accomodations.contains(accomodation)
            }
            self.absentAccomodations = expectedAccomodations.filter { accomodation in
                !accomodations.contains(accomodation)
            }
        }

        init(viewModel: ViewModel) {
            self.init(
                accomodations: viewModel.accomodations
            )
        }

        var body: some View {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(presentAccomodations, id: \.rawValue) { accomodation in
                        accomodationItem(accomodation, isPresent: true)
                    }

                    ForEach(absentAccomodations, id: \.rawValue) { accomodation in
                        accomodationItem(accomodation, isPresent: false)
                    }
                }
            }
        }

        @ViewBuilder
        private func accomodationItem(_ accomodation: RefugeAccomodation, isPresent: Bool) -> some View {
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
    RefugeDescriptionView.AccomodationsView(
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
