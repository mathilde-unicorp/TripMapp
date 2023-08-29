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
                if let refuges = viewModel.refuges {
                    viewModel.createRefugesMapAndListView(refuges: refuges)
                } else {
                    refugesListLoading(isLoading: viewModel.isLoading)
                }
            }
            .loadingTask(isLoading: $viewModel.isLoading) {
                do {
                    self.viewModel.refuges = try await viewModel.loadRefuges()
                } catch {
                    self.viewModel.hasError = true
                }
            }
            .navigationTitle(viewModel.navigationTitle)
        }
    }

    @ViewBuilder
    func refugesListLoading(isLoading: Bool) -> some View {
        if isLoading {
            ProgressView()
        }
    }

}

struct RefugesView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.shared.createRefugesView(refugeType: .refuge)
    }
}
