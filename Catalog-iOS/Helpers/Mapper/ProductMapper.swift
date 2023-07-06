//
//  ProductMapper.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation
import CoreData

struct ProductMapper {
    static func mapProductToProductModel(product: Product) -> ProductModel {
        ProductModel(productId: product.productId ?? "",
                     name: product.name ?? "",
                     desc: product.desc,
                     image: product.image,
                     isFavorited: product.isFavorited)
    }
    
    static func mapProductResponseToProduct(productResponse response: ProductResponse, moc: NSManagedObjectContext) -> Product {
        let product = Product(context: moc)
        product.productId = response.id
        product.name = response.name
        product.desc = response.description
        product.image = response.image
        product.isFavorited = false
        return product
    }
}
