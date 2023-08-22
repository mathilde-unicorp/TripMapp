//
//  ContentView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedTab: RefugePointType? = .hut

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(RefugePointType.allCases, id: \.self) { pointType in
                RefugeList(refugeType: pointType)
                    .tabItem {
                        pointType.icon
                        Text(pointType.name)
                    }
                    .tag(pointType)
                    .environmentObject(RefugesInfoData())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
