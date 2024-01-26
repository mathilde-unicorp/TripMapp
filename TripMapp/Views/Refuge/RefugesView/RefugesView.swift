//
//  RefugeList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI

struct RefugesView: View {

    @ObservedObject var viewModel: RefugesViewModel

    var body: some View {
        NavigationView {
            VStack {
                AsyncContentView(
                    source: viewModel,
                    loadingView: ProgressView()
                ) { refuges in
                    viewModel.createRefugesMapAndListView(refuges: refuges)
                }
            }
            .navigationTitle(viewModel.navigationTitle)
        }
    }
}

struct RefugesView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.shared.createRefugesView(refugeType: .refuge)
    }
}
