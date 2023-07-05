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
    
    func getProducts() async throws -> [Product] {
        let productFetch = NSFetchRequest<Product>(entityName: "Product")
        return try persistenceController.viewContext.fetch(productFetch)
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
}
