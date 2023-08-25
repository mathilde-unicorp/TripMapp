//
//  RefugeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import SwiftUI

/**
 A view that displays the details of a refuge.

 - Parameters:
    - viewModel: An observed object that manages the data and state of the refuge detail view.

 - Note: This view is responsible for displaying the refuge description and loading view based on the state of the viewModel.

 - SeeAlso: `RefugeDescriptionView`
 - SeeAlso: `RefugeLoadingView`

 - Example:
 ```
 let viewModel = RefugeDetailViewModel()
 let refugeDetailView = RefugeDetailView(viewModel: viewModel)
 ```
 */
struct RefugeDetailView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: RefugeDetailViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            if let refuge = viewModel.refuge {
                RefugeDescriptionView(viewModel: .build(from: refuge))
            } else {
                RefugeLoadingView(isLoading: viewModel.isLoading)
                    .banner(isPresented: $viewModel.hasError,
                            text: "Cannot load content :(",
                            type: .error)
            }
        }
        .loadingTask(isLoading: $viewModel.isLoading) {
            try await self.loadRefuge()
        }
    }

    private func loadRefuge() async throws {
        do {
            self.viewModel.refuge = try await viewModel.loadRefuge()
        } catch {
            self.viewModel.hasError = true
        }
    }
}

struct RefugeView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.shared.createRefugeDetailView(refugeId: 3101)
    }
}
