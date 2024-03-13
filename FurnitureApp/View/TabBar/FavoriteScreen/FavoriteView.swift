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
            ScrollView {
                ForEach(products){product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        
                        FavoriteItemView(product: product)
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button{}label: {
                        Image(systemName: "cart")
                            .tint(.main)
                    }
                }
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
                    Button{}label: {
                        Image(.bag)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22,height: 22)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(hex: 0xE0E0E0).opacity(0.6))
                            )
                        
                    }
                    
                }
            }.padding()
            
            Divider()
                .padding(.horizontal)
        }
    }
}
