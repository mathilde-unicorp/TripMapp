//
//  ContentView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    private let router: AppRouter = .shared

    var body: some View {
        router.createMassifsView()
//        router.createRefugesByTypeTabView(tabs: [.refuge, .hut, .bedAndBreakfast])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
