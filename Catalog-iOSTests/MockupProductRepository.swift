//
//  MockupProductRepository.swift
//  Catalog-iOSTests
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation

@testable import Catalog_iOS

class ProductRepository: ProductRepositoryProtocol {
    private let dummyArray: [ProductModel]
    
    var isUpdateFunctionCalled = false
    
    init(dummyArray: [ProductModel]) {
        self.dummyArray = dummyArray
    }
    
    func getProducts() async throws -> [ProductModel] {
        dummyArray
    }
    
    func getProducts(search: String) async throws -> [ProductModel] {
        dummyArray.filter { $0.name.contains(search) }
    }
    
    func getFavoritedProducts() async throws -> [ProductModel] {
        dummyArray.filter { $0.isFavorited }
    }
    
    func updateProduct(product: ProductModel, isFavorited: Bool) async throws {
        self.isUpdateFunctionCalled = true
    }
}
