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
}
