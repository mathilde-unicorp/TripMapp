//
//  RefugesByTypeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI

struct RefugesByTypeTabView: View {

    @ObservedObject var viewModel: RefugesByTypeTabViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(viewModel.tabs, id: \.self) { pointType in
                RefugesView(viewModel: .init(refugeType: pointType, dataProvider: RefugesInfoDataProvider(), router: viewModel.router))
//                AppRouter.shared.createRefugesView(refugeType: pointType)
                    .tabItem {
                        pointType.icon
                        Text(pointType.name)
                    }
                    .tag(pointType)
            }
        }
    }
}

struct RefugesByType_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.shared.createRefugesByTypeTabView(
            tabs: [.hut, .bedAndBreakfast, .refuge]
        )
    }
}