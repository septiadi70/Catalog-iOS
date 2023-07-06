//
//  ProductRepositoryProtocol.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation
import CoreData

protocol ProductRepositoryProtocol {
    func getProducts() async throws -> [ProductModel]
    func updateProduct(product: ProductModel, isFavorited: Bool) async throws
}
