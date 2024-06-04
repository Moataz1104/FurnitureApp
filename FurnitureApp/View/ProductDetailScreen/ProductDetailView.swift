//
//  ProductDetailView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 07/03/2024.
//

import SwiftUI
import NukeUI
struct ProductDetailView: View {
    @StateObject private var viewModel = ProductDetailViewModel()
    @EnvironmentObject var cartManager : CartManager
    @State private var showAlert = false
    @State var isFav : Bool
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var productDetail : ProductModel?
    var product : Product?

    var body: some View {
        ZStack(alignment:.bottom){
            ScrollView{
                VStack{
                    if let productDetail{
                        ImagesSliderView(viewModel: viewModel, productDetail: productDetail, screenWidth: screenWidth, screenHeight: screenHeight)
                    }else{
                        ImagesSliderView(viewModel: viewModel, screenWidth: screenWidth, screenHeight: screenHeight)
                        
                    }
                    
                    ProductInfoView(viewModel: viewModel)
                        .padding(.bottom)
                    ProductMetaDataView(viewModel: viewModel)
                    
                }
                .toolbar{
                    ToolbarItem(placement: .confirmationAction) {
                        BarButtonView( viewModel: viewModel, isFav: isFav)
                    }
                }
                .onAppear{
                    if let productDetail{
                        viewModel.fetchProductDetails(id:productDetail.webID)
                    }else if let product{
                        viewModel.getShortText(fetched: product)
                        viewModel.getLongText(fetched: product)
                        viewModel.productDetails = product
                    }
                    
                }
                if let product = viewModel.productDetails{
                    Button{
                        showAlert = true
                        cartManager.addToCart(product: product)
                    }label: {
                        Text("Add to cart +")
                            .font(.system(size: 18,weight: .semibold))
                            .padding()
                            .foregroundStyle(.white)
                            .frame(width: 250 )
                            .background(.main)
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom)
                    .alert("Added successfully ✅", isPresented: $showAlert, actions: {})

                    
                }

            }
            
            
        }
        
    }
}


struct ImagesSliderView: View {
    @StateObject var viewModel : ProductDetailViewModel
    var productDetail : ProductModel?

    let screenWidth:Double
    let screenHeight:Double
    @State private var isSheet = false
    var body: some View {
        VStack{
            TabView{
                ForEach(viewModel.productDetails?.allImages ?? [],id:\.self) { item in
                    AsyncImage(url: URL(string: item.newUrl ?? "")){image in
                        image
                            .image?
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenWidth,height: screenHeight * 0.6)
                    }
                }
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .frame(width: screenWidth,height: screenHeight * 0.6)
    }
}


struct ProductInfoView:View {
    @StateObject var viewModel:ProductDetailViewModel
    var body: some View {
        if viewModel.isLoading{
            ProgressView()
        }else{
            VStack{
                Text(viewModel.productDetails?.productTitle ?? "UnKnown")
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .font(.custom("Gelasio-Medium", size: 24))
                    .padding(.top)
                
                HStack{
                    Text("$\(Int(viewModel.productDetails?.price?.regularPrice?.minPrice ?? -1))")
                        .font(.system(size: 30,weight: .bold))
                    Spacer()
                    VStack(alignment:.leading){
                        HStack{
                            Image(systemName: "star.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(.yellow)
                            Text(viewModel.productDetails?.avgRating ?? "0")
                                .font(.system(size: 22,weight: .bold))
                        }
                        NavigationLink(destination: ReviewView(product: viewModel.productDetails)) {
                            Text("Reviews")
                                .underline()
                                .font(.system(size: 17,weight: .semibold))
                                .foregroundStyle(Color(hex: 0x808080))
                        }
                        .padding(.leading,5)
                    }
                }
                
                Text(viewModel.shortDesc ?? "No Description")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16,weight: .light))
                    .foregroundStyle(Color(hex: 0x606060))
                    .padding(.top,2)

            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
    }
}


struct ProductMetaDataView : View {
    @StateObject var viewModel : ProductDetailViewModel
    var body: some View {
        
        VStack(alignment:.leading){
            if let brand = viewModel.productDetails?.brand{
                HStack{
                    Text("Brand: \(brand)")
                }
                Divider()
            }
            if let totalRating = viewModel.productDetails?.ratingCount{
                Text("Total Raiting Count: \(totalRating)")
                Divider()
            }
            if let avgRating = viewModel.productDetails?.avgRating{
                HStack{
                    Text("Average Rating : ")
                    HStack(spacing:3){
                        Image(systemName: "star.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(.yellow)
                        Text(avgRating)
                    }
                }
                Divider()
            }
            if let isAvilable = viewModel.productDetails?.isStoreAvailable{
                Text("Is Avilable : \(isAvilable ? "✅" : "❌") ")
                Divider()
            }
            
            if let isNew = viewModel.productDetails?.isNew{
                Text("Is New : \(isNew ? "✅" : "❌") ")
                Divider()
            }
            
            if let recomPerc = viewModel.productDetails?.recommendedPercentage{
                Text("Recommended Percentage: \(recomPerc)%")
                Divider()
            }
            
            if let url = viewModel.productDetails?.productURL{
                HStack{
                    Text("Product Link : ")
                    HStack(alignment:.top){
                        Image(systemName: "paperclip")
                        Text(url)
                            .foregroundStyle(.blue)
                            .underline()
                    }
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: url)!)
                            
                        }
                }
                Divider()
            }
            
            if let longDesc = viewModel.longDesc{
                Text("Description:")
                Text(longDesc)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16,weight: .light))
                    .foregroundStyle(Color(hex: 0x606060))
                    .padding(.top,2)

            }
        }
        .padding(.horizontal)
    }
}

struct BarButtonView: View {
    @Environment(\.modelContext) var context
    @StateObject var viewModel : ProductDetailViewModel
    @State var isFav:Bool
    var body: some View {
        
        Button{
            if let productDetails = viewModel.productDetails{
                context.insert(productDetails)
                isFav.toggle()
            }
        }label: {
            Image(systemName: "bookmark.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(isFav ? .main : .gray.opacity(0.7))
        }
    }
}
