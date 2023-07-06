//
//  ProductLocalDataSourceTests.swift
//  Catalog-iOSTests
//
//  Created by Andi Septiadi on 06/07/23.
//

import XCTest
import CoreData

@testable import Catalog_iOS

final class ProductLocalDataSourceTests: XCTestCase {
    
    var persistenceController: TestPersistenceController!
    var dataSource: MockupProductLocalDataSource!
    
    override func setUp() {
        super.setUp()
        persistenceController = TestPersistenceController(modelName: "Model")
        dataSource = MockupProductLocalDataSource(persistenceController: persistenceController)
        try? saveMockupDatas()
    }
    
    func testSaveData() throws {
        let product = Product(context: persistenceController.viewContext)
        product.productId = "1"
        product.name = "Item"
        try persistenceController.save()
        
        XCTAssertEqual(product.productId, "1")
        XCTAssertEqual(product.name, "Item")
    }
    
    func testGetProducts() async throws {
        let products = try await dataSource.getProducts(predicate: nil)
        XCTAssertEqual(products.count, 5)
    }
    
    func testGetProduct() async throws {
        let product = await dataSource.getProduct(productId: "1")
        
        XCTAssertNotNil(product)
        XCTAssertEqual(product?.productId, "1")
        XCTAssertEqual(product?.name, "Item 1")
    }
    
    func testUpdateProduct() async throws {
        var product = Product(context: persistenceController.viewContext)
        product.productId = "1"
        product.name = "Item"
        try persistenceController.save()
        
        XCTAssertEqual(product.name, "Item")
        
        product = try await dataSource.update(product: product, value: "New Item", forKey: "name")
        
        XCTAssertEqual(product.name, "New Item")
    }
    
    func saveMockupDatas() throws {
        for i in 0...4 {
            let product = Product(context: persistenceController.viewContext)
            product.productId = "\(i)"
            product.name = "Item \(i)"
        }
        try persistenceController.save()
    }

}
