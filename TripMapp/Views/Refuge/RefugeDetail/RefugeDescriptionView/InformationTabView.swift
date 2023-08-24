//
//  RefugeDescriptionView+InformationTab.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import SwiftUI

extension RefugeDescriptionView {

    struct InformationTabView: View {
        let description: String

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("Informations")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(description)
                    .font(.body)
                
                Spacer()
                
            }
            .padding()
            .background(Color.white)
        }
    }


}

struct RefugeDescriptionView_InformationTab_Previews: PreviewProvider {
    static var previews: some View {
        RefugeDescriptionView.InformationTabView(
            description: RefugeDescriptionViewModel.mock().description
        )
    }
}
