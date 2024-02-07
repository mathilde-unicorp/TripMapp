//
//  RefugeDescriptionView+InformationTab.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import SwiftUI

extension RefugeDescriptionView {

    struct InformationsTabView: View {
        let viewModel: RefugeDescriptionViewModel

        init(viewModel: RefugeDescriptionViewModel) {
            self.viewModel = viewModel
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 16.0) {
                Text("Équipement")
                    .font(.title2)
                    .fontWeight(.bold)

                AccomodationsView(viewModel: viewModel)
                    .frame(height: 200)

                Text("Informations")
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
