//
//  RefugeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import SwiftUI



struct RefugeDetailView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: RefugeDetailViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            AsyncContentView(
                source: viewModel,
                loadingView: RefugeLoadingView()
            ) { refuge in
                RefugeDescriptionView(viewModel: .build(from: refuge))
            }
        }
    }
}

struct RefugeView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.shared
            .createRefugeDetailView(refugeId: 6179)
    }
}
