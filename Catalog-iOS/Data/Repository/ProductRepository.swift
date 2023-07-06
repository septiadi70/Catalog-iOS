//
//  ProductRepository.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation
import CoreData

struct ProductRepository: ProductRepositoryProtocol {
    private let local: ProductLocalDataSourceProtocol
    
    init(local: ProductLocalDataSourceProtocol) {
        self.local = local
    }
    
    func getProducts() async throws -> [ProductModel] {
        let array = try await local.getProducts(predicate: nil)
        return array.map { ProductMapper.mapProductToProductModel(product: $0) }
    }
    
    func getProducts(search: String) async throws -> [ProductModel] {
        let predicate = NSPredicate(format: "name CONTAINS[c] %@", search)
        let array = try await local.getProducts(predicate: predicate)
        return array.map { ProductMapper.mapProductToProductModel(product: $0) }
    }
    
    func getFavoritedProducts() async throws -> [ProductModel] {
        let predicate = NSPredicate(format: "isFavorited == YES")
        let array = try await local.getProducts(predicate: predicate)
        return array.map { ProductMapper.mapProductToProductModel(product: $0) }
    }
    
    func updateProduct(product: ProductModel,
                       isFavorited: Bool) async throws {
        let model = await local.getProduct(productId: product.productId)
        guard let model
        else { throw AppError.updateProductFailed }
        _ = try await local.update(product: model, value: isFavorited, forKey: "isFavorited")
    }
}
