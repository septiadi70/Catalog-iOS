//
//  ProductRepositoryTests.swift
//  Catalog-iOSTests
//
//  Created by Andi Septiadi on 06/07/23.
//

import XCTest

@testable import Catalog_iOS

final class ProductRepositoryTests: XCTestCase {
    
    var repository: ProductRepository!

    override func setUp() {
        super.setUp()
        repository = ProductRepository(dummyArray: dummyArray())
    }
    
    func testGetProducts() async throws {
        let products = try await repository.getProducts()
        XCTAssertEqual(products.count, 5)
    }
    
    func testGetSearchProducts() async throws {
        let products = try await repository.getProducts(search: "Item 1")
        XCTAssertEqual(products.count, 1)
    }
    
    func testGetFavoritedProducts() async throws {
        let products = try await repository.getFavoritedProducts()
        XCTAssertEqual(products.count, 2)
    }
    
    func testUpdateProduct() async throws {
        let product = ProductModel(productId: "1", name: "Item 1")
        try await repository.updateProduct(product: product,
                                           isFavorited: true)
        
        XCTAssertTrue(repository.isUpdateFunctionCalled)
    }

    func dummyArray() -> [ProductModel] {
        [
            ProductModel(productId: "1", name: "Item 1"),
            ProductModel(productId: "2", name: "Item 2", isFavorited: true),
            ProductModel(productId: "3", name: "Item 3"),
            ProductModel(productId: "4", name: "Item 4", isFavorited: true),
            ProductModel(productId: "5", name: "Item 5")
        ]
    }
}
