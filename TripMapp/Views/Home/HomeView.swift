//
//  HomeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    // Not sure yet
    // @EnvironmentObject var router: AppRouter

    var body: some View {
        TabView {
            HomeMapView()
                .tabItem {
                    Label("map", systemImage: "map")
                }

            HomeProjectsView()
                .tabItem {
                    Label("projects", systemImage: "list.bullet.clipboard")
                }
        }
        .background(.ultraThickMaterial)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
    }
}
