//
//  Injection.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation

struct Injection {
    private func provideProductRepository() -> ProductRepositoryProtocol {
        let persistenceController = PersistenceController(modelName: "Model")
        let local = ProductLocalDataSource(persistenceController: persistenceController)
        return ProductRepository(local: local)
    }
    
    @MainActor func provideListController() -> ListController {
        ListController(repository: provideProductRepository())
    }
}
