//
//  ContentView.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 05/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var controller: ListController
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(controller.products, id: \.productId) { product in
                        VStack() {
                            ZStack {
                                AsyncImage(url: URL(string: product.image ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .frame(width: 170, height: 170)
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button {
                                            controller.updateProducts(product: product)
                                        } label: {
                                            if product.isFavorited {
                                                Image(systemName: "bookmark.fill")
                                            } else {
                                                Image(systemName: "bookmark")
                                            }
                                        }
                                        .foregroundColor(Color.red)
                                        .font(.system(size: 24))
                                        .padding(EdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0))
                                    }
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0))
                                .background(Color.clear)
                            }
                            Text(product.name)
                                .font(.system(size: 16.0, weight: .bold, design: .default))
                            Spacer()

                        }
                        .frame(width: 170)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .searchable(text: $controller.search)
        .onChange(of: controller.search, perform: { newValue in
            if newValue.isEmpty {
                controller.loadProducts()
            } else {
                search()
            }
        })
        .task {
            controller.loadProducts()
        }
    }
    
    private func search() {
        Task {
            await controller.loadSearchProducts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(controller: Injection().provideListController())
    }
}
