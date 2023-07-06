//
//  ProductLocalDataSource.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 05/07/23.
//

import CoreData

struct ProductLocalDataSource: ProductLocalDataSourceProtocol {
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func getProducts(predicate: NSPredicate?) async throws -> [Product] {
        let productFetch = NSFetchRequest<Product>(entityName: "Product")
        let sortDescriptors = NSSortDescriptor(key: #keyPath(Product.productId),
                                               ascending: true)
        productFetch.sortDescriptors = [sortDescriptors]
        
        if let predicate { productFetch.predicate = predicate }
        
        var products = try persistenceController.viewContext.fetch(productFetch)
        
        return products
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
