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
}
