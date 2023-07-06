//
//  Injection.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation

struct Injection {
    private func provideProductRepository() -> ProductRepositoryProtocol {
        ProductRepository(local: provideProductLocalDataSource())
    }
    
    func provideProductLocalDataSource() -> ProductLocalDataSourceProtocol {
        let persistenceController = PersistenceController(modelName: "Model")
        return ProductLocalDataSource(persistenceController: persistenceController)
    }
    
    @MainActor func provideListController() -> ListController {
        ListController(repository: provideProductRepository())
    }
}
