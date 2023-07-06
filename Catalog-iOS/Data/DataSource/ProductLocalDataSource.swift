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
    
    func getProducts(search: String) async throws -> [Product] {
        let productFetch = NSFetchRequest<Product>(entityName: "Product")
        let sortDescriptors = NSSortDescriptor(key: #keyPath(Product.productId),
                                               ascending: true)
        productFetch.sortDescriptors = [sortDescriptors]
        
        if !search.isEmpty {
            productFetch.predicate = NSPredicate(format: "name CONTAINS[c] %@", search)
        }
        
        var products = try persistenceController.viewContext.fetch(productFetch)
        
        if products.isEmpty {
            try await loadProductFromFile()
            products = try persistenceController.viewContext.fetch(productFetch)
        }
        
        return products
    }
    
    func saveProduct(productId: String,
                     name: String,
                     desc: String?,
                     image: String?,
                     isFavorited: Bool) {
        let product = Product(context: persistenceController.viewContext)
        product.productId = productId
        product.name = name
        product.desc = desc
        product.image = image
        product.isFavorited = isFavorited
        persistenceController.save()
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
    
    private func productResponsesFromFromFile() async throws -> [ProductResponse] {
        // Data dummy from https://dummyjson.com/products
        guard let path = Bundle.main.path(forResource: "Products", ofType: "json")
        else {
            // TODO: Error handle
            return []
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let array = try decoder.decode([ProductResponse].self, from: data)
            return array
        } catch {
            throw error
        }
    }
    
    private func loadProductFromFile() async throws {
        let products = try await productResponsesFromFromFile()
        let _ = products.map { ProductMapper.mapProductResponseToProduct(productResponse: $0, moc: persistenceController.viewContext) }
        persistenceController.save()
    }
}
