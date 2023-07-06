//
//  PersistenceController.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 05/07/23.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init(modelName: String) {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
#if DEBUG
            print(error)
#endif
        }
    }
}
