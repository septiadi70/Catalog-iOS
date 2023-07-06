//
//  ProductResponse.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation

struct ProductResponse: Decodable {
    var id: String
    var name: String
    var description: String?
    var image: String?
}
