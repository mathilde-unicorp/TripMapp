//
//  RefugeTitleView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import SwiftUI

extension RefugeDescriptionView {
    struct Title: View {
        let icon: Image
        let title: String
        let placeId: RefugeId
        let url: URL

        init(icon: Image, title: String, placeId: RefugeId, url: URL) {
            self.icon = icon
            self.title = title
            self.placeId = placeId
            self.url = url
        }

        init(viewModel: ViewModel) {
            self.icon = Image(systemName: viewModel.systemImage)
            self.title = viewModel.name
            self.placeId = viewModel.placeId
            self.url = viewModel.url
        }

        // ---------------------------------------------------------------------
        // MARK: - Body
        // ---------------------------------------------------------------------

        var body: some View {
            HStack(spacing: 24.0) {
                VStack {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                        .foregroundColor(.green)

                    Text("item_id_description \(placeId.description)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)

                    Button(action: {
                        UIApplication.shared.open(url)
                    }, label: {
                        Image(systemName: "arrow.up.forward.square")
                        Text("source_refuges_info_title")
                    })
                }

                Spacer()
            }
        }
    }
}

#Preview {
    RefugeDescriptionView.Title(
        icon: Image(systemName: "tent"),
        title: "Mock Place With Long Name",
        placeId: 1234,
        url: .giteDeLaColleStMichel
    )
}
