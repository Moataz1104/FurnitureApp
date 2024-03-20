//
//  MapView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 02/03/2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject private var cartManager : CartManager
    @State var cartProducts = [Product]()
    var body: some View {
        NavigationStack{
            VStack{
                if cartProducts.isEmpty{
                    Image(.noCart)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300,height: 450)
                    
                }else{
                    ScrollView(showsIndicators:false){
                        ScrollView{
                            ForEach(cartProducts) { product in
                                CartProductView(cartProducts:$cartProducts, product: product)
                            }
                        }
                        .padding(.top)
                        .navigationTitle("My Cart")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        Spacer()
                        CheckOutView()
                            .padding(.vertical)
                        
                    }
                }
            }
            .onAppear{
                cartProducts = cartManager.cartProducts
                print("Cart View Proudcts count: \(cartManager.cartProducts.count)")
            }
            .onDisappear{
                cartManager.cartProducts = cartProducts
            }
            
        }
    }
    
}

#Preview {
    CheckOutView()
}

struct CartProductView: View {
    @Binding var cartProducts : [Product]
    let product : Product
    var body: some View {
        VStack{
            HStack(alignment:.top){
                HStack{
                    //                    Image(.testii)
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                        .clipShape(.rect(cornerRadius: 10))
                    //                        .frame(width: 100,height: 100)
                    AsyncImage(url:
                                URL(string: product.allImages?.first?.newUrl ?? "")!){image in
                        if let image = image.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                                .frame(width: 100,height: 100)
                            
                        }else{
                            ProgressView()
                                .frame(width: 100,height: 100)
                        }
                    }
                    
                    VStack(alignment:.leading){
                        Text(product.productTitle ?? "No Title")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundStyle(.subTitle)
                        
                        Text("$\(Int((product.price?.regularPrice?.minPrice) ?? 0) )")
                            .font(.system(size: 16,weight: .bold))
                            .padding(.top,5)
                        
                        Spacer()
                        
                        HStack(spacing:20){
                            Button{}label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(.black)
                                    .frame(width: 30,height: 30)
                                    .background(Color(hex: 0xE0E0E0))
                                    .clipShape(.rect(cornerRadius: 4))
                                
                            }
                            Text("01")
                                .font(.system(size: 17,weight: .semibold))
                            
                            Button{}label: {
                                Image(systemName: "minus")
                                    .foregroundStyle(.black)
                                    .frame(width: 30,height: 30)
                                    .background(Color(hex: 0xE0E0E0))
                                    .clipShape(.rect(cornerRadius: 4))
                                
                            }
                            
                        }
                        
                    }.padding(.vertical,5)
                }
                Spacer()
                
                Button{
                    cartProducts.removeAll(where: {$0 == product})
                }label: {
                    Image(systemName: "x.circle")
                        .font(.title2)
                        .foregroundStyle(.main)
                }
                .padding([.top,.trailing],5)
                
            }
            Divider()
                .padding(.horizontal)
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
    }
}

struct CheckOutView:View {
    var body: some View {
        VStack(spacing:20){
            HStack{
                Text("Total:")
                    .font(.system(size: 20,weight: .bold))
                    .foregroundStyle(Color(hex: 0x808080))
                Spacer()
                Text("$95")
                    .font(.system(size: 20,weight: .bold))
            }
            .padding(.horizontal)
            
            
            Button{}label: {
                Text("Check Out")
                    .font(.system(size: 20,weight: .semibold))
                    .padding()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.main)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
            }
        }
    }
}
