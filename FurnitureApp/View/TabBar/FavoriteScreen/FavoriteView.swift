//
//  FavoriteView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 02/03/2024.
//

import SwiftUI
import SwiftData
struct FavoriteView: View {
    @Environment(\.modelContext) var context
    @Query(sort:\Product.productTitle) private var products : [Product]
    @StateObject private var viewModel = ProductDetailViewModel()
    var body: some View {
        NavigationStack{
            if products.isEmpty{
                Image(.emptyState)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300,height: 450)
            }else{
                ScrollView {
                    ForEach(products){product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            
                            FavoriteItemView(product: product)
                        }
                    }
                }
                .navigationTitle("Favorites")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct FavoriteItemView: View {
    @State var product : Product
    @Environment(\.modelContext) var context
    var body: some View {
        VStack{
            HStack(alignment:.top){
                HStack(alignment:.top){
                    
                    AsyncImage(url: URL(string: product.allImages?[1].newUrl ?? "")){image in
                        if let image = image.image{
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: 100,height: 100)
                        }else{
                            ProgressView()
                                .frame(width: 100,height: 100)
                        }
                    }
                    VStack(alignment:.leading,spacing:15){
                        Text(product.productTitle ?? "No title")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color(hex: 0x606060))
                        
                        Text("$\(Int(product.price?.regularPrice?.minPrice ?? -1))")
                            .font(.system(size: 20,weight: .bold))
                            .foregroundStyle(Color(hex: 0x303030))
                        
                    }
                    
                }
                Spacer()
                VStack{
                    Button{
                        context.delete(product)
                    }label: {
                        Image(systemName: "x.circle")
                            .font(.title2)
                            .foregroundStyle(.main)
                    }
                    Spacer()
                    EmptyView()
                }
            }.padding()
            
            Divider()
                .padding(.horizontal)
        }
    }
}
