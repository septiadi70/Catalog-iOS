//
//  GridCell.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import SwiftUI

struct GridCell: View {
    var product: ProductModel
    var bookmarkAction: () -> Void
    
    var body: some View {
        VStack() {
            ZStack {
                AsyncImage(url: URL(string: "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .frame(width: 170, height: 170)
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            if product.isFavorited {
                                Image(systemName: "bookmark.fill")
                            } else {
                                Image(systemName: "bookmark")
                            }
                        }
                        .foregroundColor(Color.gray)
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

struct GridCell_Previews: PreviewProvider {
    static var previews: some View {
        GridCell(product: ProductModel(productId: "1", name: "Item 1", image: "", isFavorited: true)) {
            
        }
    }
}
