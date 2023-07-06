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
        do {
            let array = try await local.getProducts()
            return array.map { ProductMapper.mapProductToProductModel(product: $0) }
        } catch {
            throw error
        }
    }
    
    func updateProduct(product: ProductModel,
                       isFavorited: Bool) async throws {
        let model = await local.getProduct(productId: product.productId)
        guard let model
        else {
            // TODO: Error handle
            return
        }
        _ = try await local.update(product: model, value: isFavorited, forKey: "isFavorited")
    }
}
