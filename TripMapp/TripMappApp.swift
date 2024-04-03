//
//  TripMappApp.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI

@main
struct TripMappApp: App {
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
