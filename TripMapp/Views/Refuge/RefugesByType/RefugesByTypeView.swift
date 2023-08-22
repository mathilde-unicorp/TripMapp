//
//  RefugesByTypeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI

struct RefugesByTypeView: View {

    let tabs: [RefugesInfo.PointType]

    @EnvironmentObject var refugesInfoData: RefugesInfoData

    @State private var selectedTab: RefugesInfo.PointType? = .hut

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs, id: \.self) { pointType in
                RefugesView(refugeType: pointType)
                    .environmentObject(RefugesInfoData())
                    .tabItem {
                        pointType.icon
                        Text(pointType.value)
                    }
                    .tag(pointType)
            }
        }
    }
}

struct RefugesByType_Previews: PreviewProvider {
    static var previews: some View {
        RefugesByTypeView(tabs:  [.refuge, .hut, .bedAndBreakfast])
            .environmentObject(RefugesInfoData())
    }
}
