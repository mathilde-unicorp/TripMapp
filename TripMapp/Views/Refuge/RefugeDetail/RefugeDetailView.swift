//
//  RefugeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 04/05/2023.
//

import SwiftUI

class RefugeDetaiViewModel: ObservableObject {

    @Published var refuge: RefugesInfo.RefugePoint?
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true

    private let refugeId: Int

    private let dataProvider: RefugesInfoDataProviderProtocol
    private let router: AppRouter

    init(refugeId: Int, dataProvider: RefugesInfoDataProviderProtocol, router: AppRouter) {
        self.refugeId = refugeId
        self.dataProvider = dataProvider
        self.router = router
    }

    func loadRefuge() async throws {
        do {
            self.refuge = try await dataProvider.loadRefuge(id: refugeId)
        } catch {
            self.hasError = true
        }
    }
}

/**
 A view that displays detailed information about a refuge.

 Use this view to show specific details about a refuge, such as its name, location, description, and contact information.

 Example usage:
 ```
 let refugeDetail = RefugeDetailView(id: 1234)
     .environmentObject(RefugesInfoData())
 ```
 */
struct RefugeDetailView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: RefugeDetaiViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            if let refuge = viewModel.refuge {
                RefugeDescriptionView(viewModel: .build(from: refuge))
            } else {
                RefugeDetailView.refugeLoadingView(isLoading: viewModel.isLoading)
                    .banner(isPresented: $viewModel.hasError, text: "Cannot load content :(", type: .error)
            }
        }
        .loadingTask(isLoading: $viewModel.isLoading) {
            try await viewModel.loadRefuge()
        }
    }
}


struct RefugeView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.shared.createRefugeDetailView(refugeId: 3101)
    }
}
