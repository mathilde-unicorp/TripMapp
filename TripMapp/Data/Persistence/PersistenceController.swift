//
//  Persistence.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    static let preview = PersistenceController(inMemory: true)

    // -------------------------------------------------------------------------
    // MARK: - Properties
    // -------------------------------------------------------------------------

    let container: NSPersistentContainer

    var context: NSManagedObjectContext {
        container.viewContext
    }

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    /// Create aPersistenceController for `TripMapp`.
    /// If the controller is `inMemory`, it won't keep it between two executions (perfect for previews)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TripMapp")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("-------------------------------- FATAL ERROR --------------------------------")
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true

        if inMemory {
            generateInMemoryContent()
        }
    }
}
