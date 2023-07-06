//
//  ProductLocalDataSourceProtocol.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 05/07/23.
//

import CoreData

protocol ProductLocalDataSourceProtocol {
    func getProducts(predicate: NSPredicate?) async throws -> [Product]
    func getProduct(productId id: String) async -> Product?
    func update(product: Product, value: Any, forKey key: String) async throws -> Product
}
