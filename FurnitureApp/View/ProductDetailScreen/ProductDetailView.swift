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
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var productDetail : ProductModel?
    var product : Product?
    

    var body: some View {
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
                
                if !viewModel.isLoading{
                    FooterButtonsView(viewModel: viewModel)
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
                        Text("(50 reviews)")
                            .font(.system(size: 17,weight: .semibold))
                            .foregroundStyle(Color(hex: 0x808080))
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
                            print("url Tapped")
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

struct FooterButtonsView: View {
    @Environment(\.modelContext) var context
    @StateObject var viewModel : ProductDetailViewModel
    @State private var isFav = false
    var body: some View {
        
        Button{
            if let productDetails = viewModel.productDetails{
                context.insert(productDetails)
            }
        }label: {
            Text("Add to Favorites +")
                .foregroundStyle(.white)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .frame(width: 280,height: 50)
                .background(.main)
            
            
        }.padding(.bottom,25)
    }
}
