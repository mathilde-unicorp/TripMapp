//
//  ContentView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var refugesInfoData = RefugesInfoData()

    var body: some View {
        RefugeDetailView(id: "4889")
            .environmentObject(refugesInfoData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
