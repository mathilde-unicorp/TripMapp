//
//  RefugeDescriptionView+InformationTab.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import SwiftUI

extension RefugeDescriptionView {

    struct InformationsTabView: View {
        let viewModel: ViewModel

        init(viewModel: ViewModel) {
            self.viewModel = viewModel
        }

        // ---------------------------------------------------------------------
        // MARK: - Body
        // ---------------------------------------------------------------------

        var body: some View {
            VStack(alignment: .leading, spacing: 16.0) {
                Text("equipment_title")
                    .font(.title2)
                    .fontWeight(.bold)

                CapacityView(viewModel: viewModel)

                EquipmentsView(viewModel: viewModel)
                    .frame(height: 100)

                Text("informations_title")
                    .font(.title2)
                    .fontWeight(.bold)

                Text(viewModel.note)
                    .font(.body)

                Spacer()

            }
            .padding()
        }
    }
}

struct RefugeDescriptionView_InformationTab_Previews: PreviewProvider {
    static var previews: some View {
        RefugeDescriptionView.InformationsTabView(
            viewModel: .mock()
        )
    }
}
