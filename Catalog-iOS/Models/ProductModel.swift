//
//  ProductModel.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 05/07/23.
//

import Foundation

struct ProductModel: Decodable {
    var productId: String
    var name: String
    var desc: String?
    var image: String?
    var isFavorited: Bool = false
}
