//
//  AccomodationsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/02/2024.
//

import SwiftUI

struct AccomodationsView: View {
    private let cellSize: CGFloat = 24.0
    private let expectedAccomodations: [RefugeAccomodation] = RefugeAccomodation.allCases

    private let places: Int
    private let mattressPlaces: Int
    private let presentAccomodations: [RefugeAccomodation]
    private let absentAccomodations: [RefugeAccomodation]

    init(
        places: Int,
        mattressPlaces: Int,
        accomodations: [RefugeAccomodation]
    ) {
        self.places = places
        self.mattressPlaces = mattressPlaces
        self.presentAccomodations = expectedAccomodations.filter { accomodation in
            accomodations.contains(accomodation)
        }
        self.absentAccomodations = expectedAccomodations.filter { accomodation in
            !accomodations.contains(accomodation)
        }
    }

    init(viewModel: RefugeDescriptionViewModel) {
        self.init(
            places: viewModel.places,
            mattressPlaces: viewModel.mattressPlaces,
            accomodations: viewModel.accomodations
        )
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                capacityItem(
                    imageSystemName: "person.2",
                    text: "Places prévues pour dormir",
                    value: places
                )

                Divider()

                capacityItem(
                    imageSystemName: "bed.double",
                    text: "Places sur matelas",
                    value: mattressPlaces
                )
            }
            .padding()
            .background(Color.systemGroupedBackground)

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(presentAccomodations, id: \.rawValue) { accomodation in
                        accomodationItem(
                            accomodation,
                            isPresent: true
                        )
                    }

                    ForEach(absentAccomodations, id: \.rawValue) { accomodation in
                        accomodationItem(
                            accomodation,
                            isPresent: false
                        )
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func capacityItem(imageSystemName: String, text: String, value: Int) -> some View {
        HStack {
            Image(systemName: imageSystemName)
                .resizable()
                .scaledToFit()
                .frame(width: cellSize, height: cellSize)

            Text(text)
                .font(.caption)

            Spacer()

            Text("\(value)")
                .font(.headline)
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

#Preview {
    AccomodationsView(
        places: 10,
        mattressPlaces: 8,
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
