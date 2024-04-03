//
//  HomeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {

    private let router: AppRouter = .shared

    var body: some View {
        router.createRefugesView()
            .environmentObject(router)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
