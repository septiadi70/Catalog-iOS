//
//  TestPersistenceController.swift
//  Catalog-iOSTests
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation
import CoreData

struct TestPersistenceController {
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init(modelName: String) {
        container = NSPersistentContainer(name: "Model")
        container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() throws {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            throw error
        }
    }
}
