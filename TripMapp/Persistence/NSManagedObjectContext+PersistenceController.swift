//
//  NSManagedObjectContext+PersistenceController.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 28/06/2024.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    /// Easy access to a view context that should be used only on `previews`
    static var previewViewContext = PersistenceController.preview.container.viewContext

    /// Easy access to a view context that is used in the real worl application
    static var sharedViewContext = PersistenceController.shared.container.viewContext
}
