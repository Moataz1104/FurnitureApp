//
//  MapView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 02/03/2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var navigationStateManager: NavigationStateManager<AppNavigationPath>

    @EnvironmentObject private var cartManager : CartManager
    @StateObject var viewModel = CartViewModel()
    var body: some View {
            VStack{
                if viewModel.cartProducts.isEmpty{
                    Image(.noCart)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300,height: 450)
                    
                }else{
                    VStack{
                        ScrollView{
                            ForEach(Array(viewModel.cartProducts.keys) , id: \.self) { product in
                                CartProductView(viewModel:viewModel, product: product)
                            }
                        }
                        .padding(.top)
                        .navigationTitle("My Cart")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        Spacer()
                        BillView(navigationStateManager: navigationStateManager, viewModel: viewModel)
                            .padding(.vertical)
                        
                    }
                }
            }
            .onAppear{
                viewModel.cartProducts = cartManager.cartProducts
                print("Cart View Proudcts count: \(cartManager.cartProducts.count)")
            }
            .onDisappear{
                cartManager.cartProducts = viewModel.cartProducts
            }
            
        

    }
    
}

//#Preview {
//    CheckOutView()
//}
//
struct CartProductView: View {
    @StateObject var viewModel : CartViewModel
    let product : Product
    @State var reachMin = true
    @State var reachMax = false
    var body: some View {
        VStack{
            HStack(alignment:.top){
                HStack{
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
                        
                        Text("$\(Int((product.price?.regularPrice?.minPrice) ?? 0) * (viewModel.cartProducts[product] ?? 0))")
                            .font(.system(size: 16,weight: .bold))
                            .padding(.top,5)
                        
                        Spacer()
                        
                        HStack(spacing:20){
                            Button{
                                viewModel.cartProducts[product]! += 1
                            }label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(reachMax ? .black.opacity(0.2) : .black)
                                    .frame(width: 30,height: 30)
                                    .background(Color(hex: 0xE0E0E0))
                                    .clipShape(.rect(cornerRadius: 4))
                            }
                            .disabled(reachMax ? true : false)

                            Text("\(viewModel.cartProducts[product] ?? 0)")
                                .font(.system(size: 17,weight: .semibold))
                            
                            Button{
                                viewModel.cartProducts[product]! -= 1

                            }label: {
                                Image(systemName: "minus")
                                    .foregroundStyle(reachMin ? .black.opacity(0.5) : .black)
                                    .frame(width: 30,height: 30)
                                    .background(Color(hex: 0xE0E0E0))
                                    .clipShape(.rect(cornerRadius: 4))
                                
                            }                                  
                            .disabled(reachMin ? true : false)

                            
                        }
                        .onChange(of: viewModel.cartProducts[product]) { oldValue, newValue in
                            if let stepperValue = newValue{
                                if stepperValue <= 1{
                                    reachMin = true
                                }else if stepperValue == 7 {
                                    reachMax = true
                                }else{
                                    reachMin = false
                                    reachMax = false
                                }
                            }
                        }
                        
                    }.padding(.vertical,5)
                }
                Spacer()
                
                Button{
                    viewModel.cartProducts.removeValue(forKey: product)
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

struct BillView:View {
    var navigationStateManager: NavigationStateManager<AppNavigationPath>
    @StateObject var viewModel : CartViewModel
    var body: some View {
        VStack(spacing:20){
            HStack{
                Text("Total:")
                    .font(.system(size: 20,weight: .bold))
                    .foregroundStyle(Color(hex: 0x808080))
                Spacer()
                Text("$ \(viewModel.totalCost)")
                    .font(.system(size: 20,weight: .bold))
            }
            .padding(.horizontal)
            
            
//            NavigationLink(destination: CheckOutView(totalCost: viewModel.totalCost)) {
//                Text("Check Out")
//                    .font(.system(size: 20,weight: .semibold))
//                    .padding()
//                    .foregroundStyle(.white)
//                    .frame(maxWidth: .infinity)
//                    .background(.main)
//                    .clipShape(.rect(cornerRadius: 10))
//                    .padding(.horizontal)
//
//            }
            
            Button{
                navigationStateManager.pushToStage(stage: .checkOut(viewModel.totalCost))
                print("navigationStateManager tapped")
            }label: {
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



