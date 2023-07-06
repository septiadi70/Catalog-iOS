//
//  ListController.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation

@MainActor
class ListController: ObservableObject {
    private let repository: ProductRepositoryProtocol
    
    @Published var products: [ProductModel] = []
    @Published var search: String = ""
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadProducts() {
        Task {
            do {
                products = try await repository.getProducts()
            } catch {
                print(error)
            }
        }
    }
    
    func loadSearchProducts() async {
        do {
            products = try await repository.getProducts(search: search)
        } catch {
            print(error)
        }
    }
    
    func loadFavoritedProducts() {
        Task {
            do {
                products = try await repository.getFavoritedProducts()
            } catch {
                print(error)
            }
        }
    }
    
    func updateProducts(product: ProductModel) {
        let i = products.firstIndex(of: product)
        Task {
            do {
                try await repository.updateProduct(product: product,
                                                   isFavorited: !product.isFavorited)
                if let index = i {
                    products[index].isFavorited.toggle()
                }
            }
        }
    }
}
