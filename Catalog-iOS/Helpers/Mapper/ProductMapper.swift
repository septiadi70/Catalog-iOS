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
}
