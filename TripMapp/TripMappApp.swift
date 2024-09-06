//
//  TripMappApp.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI

@main
struct TripMappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // -------------------------------------------------------------------------
    // MARK: - Shared App Content
    // -------------------------------------------------------------------------

    let persistenceController = PersistenceRepository.shared
    let appRouter = AppRouter.shared
    let appSettings = AppSettings.shared

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some Scene {
        WindowGroup {
            HomeView()
                .configureEnvironment(
                    persistenceController: persistenceController,
                    appRouter: appRouter
                )
                .onAppear {
                    self.setupApplication()
                }
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Setup App
    // -------------------------------------------------------------------------

    private func setupApplication() {
        if self.appSettings.shouldSetupFavoriteTripPointTypes {
            self.persistenceController.setupDefaultFavoriteTripPointTypes()
            self.appSettings.shouldSetupFavoriteTripPointTypes = false
        }
    }
}

// =============================================================================
// MARK: - App Environment
// =============================================================================

extension View {

    func configureEnvironment(
        persistenceController: PersistenceRepository,
        appRouter: AppRouter
    ) -> some View {
        self
            // Local data access
            .environment(\.managedObjectContext, persistenceController.context)
            .environmentObject(appRouter) // TODO: TEMP
    }

    /// Default env configuration for `Previews`
    func configureEnvironmentForPreview() -> some View {
        self
            .configureEnvironment(
                persistenceController: .preview,
                appRouter: .mock
            )
    }
}
