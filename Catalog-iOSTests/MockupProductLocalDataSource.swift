//
//  MockupProductLocalDataSource.swift
//  Catalog-iOSTests
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation
import CoreData

@testable import Catalog_iOS

struct MockupProductLocalDataSource: ProductLocalDataSourceProtocol {
    private let persistenceController: TestPersistenceController
    
    init(persistenceController: TestPersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func getProducts(predicate: NSPredicate?) async throws -> [Product] {
        let productFetch = NSFetchRequest<Product>(entityName: "Product")
        if let predicate { productFetch.predicate = predicate }
        return try persistenceController.viewContext.fetch(productFetch)
    }
    
    func getProduct(productId id: String) async -> Product? {
        let productFetch = NSFetchRequest<Product>(entityName: "Product")
        productFetch.predicate = NSPredicate(format: "productId == %@", id)
        do {
            return try persistenceController.viewContext.fetch(productFetch).first
        } catch {
            return nil
        }
    }
    
    func update(product: Product, value: Any, forKey key: String) async throws -> Product {
        product.setValue(value, forKey: key)
        try persistenceController.viewContext.save()
        return product
    }
}
