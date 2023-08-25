//
//  ContentView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @ObservedObject var refugesInfoData = RefugesInfoDataProvider()

    var body: some View {
        RefugesByTypeView(tabs: [.refuge, .hut, .bedAndBreakfast])
            .environmentObject(refugesInfoData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
