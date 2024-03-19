//
//  ReviewView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 13/03/2024.
//

import SwiftUI

struct ReviewView: View {
    @StateObject private var viewModel = ReviewsViewModel()
    var product : Product?
    var body: some View {
        NavigationStack{
            ScrollView{
                ProductReviewView(viewModel: viewModel, product: product!)
                
                
                ForEach(viewModel.reviews,id:\.userNickname){review in
                    ReviewDetailView(review: review)

                }
                
                PaginationReviewsView(viewModel: viewModel, product: product)
            }
            .onAppear{viewModel.fetchReviewsData(id: product?.webID ?? "")}
            .navigationTitle("Rating & Review")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProductReviewView: View {
    @StateObject var viewModel : ReviewsViewModel
    var product : Product
    var body: some View {
        VStack{
            HStack{
                AsyncImage(
                    url:URL(string: product.allImages?[0].newUrl ?? "")
                ){image in
                    image
                        .image?
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 100,height: 100)
                    
                
                
                }
                

                
                VStack(alignment:.leading,spacing:15){
                    Text(product.productTitle ?? "No Data")
                    HStack(spacing:5){
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(product.avgRating ?? "0")")
                    }
                    .font(.system(size: 24,weight: .bold))
                    
                    Text("\(viewModel.totalReviews) Reviews")
                        .font(.system(size: 20,weight: .semibold))
                    
                }
                .padding(.leading)
                Spacer()
            }
            .padding(.leading)
        }
        .padding(.top,40)
        Divider()
            .padding(.top,10)
            .padding(.horizontal)

    }
}

struct ReviewDetailView: View {
    var review:ReviewResult
    var body: some View {
        
        if let nickName = review.userNickname , let reviewText = review.reviewText{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
                VStack(alignment:.leading,spacing:10){
                    HStack{
                        Text(nickName)
                        Spacer()
                        Text(review.formattedLastModificationTime ?? "")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                    }
                    HStack(spacing:2){
                        ForEach(0..<5,id:\.self){index in
                            Image(systemName: "star.fill")
                                .foregroundColor(review.rating! > index ? .yellow : .gray)
                        }
                        
                        Spacer()
                        
                    }
                    Text(reviewText)
                        .font(.system(size: 15,weight: .regular))
                        .padding(.top)
                }
                .padding()
            }
            .padding()
        }
    }
}

struct PaginationReviewsView :View {
    @StateObject var viewModel : ReviewsViewModel
    var product : Product?
    var body: some View {
        if viewModel.reviews.isEmpty{
            ProgressView()
        }else if viewModel.reviews.count > Int(viewModel.totalReviews)!{
            EmptyView()
        }
        else{
            Button{
                viewModel.fetchMoreReviewsData(id: (product?.webID)! )
            }label: {
                HStack(spacing:3){
                    Text("More Reviews")
                    
                    Image(systemName: "arrow.down")
                    
                    if viewModel.isLoading{
                        ProgressView()
                            .tint(.white)
                    }
                }
                .foregroundStyle(.white)
                .padding(10)
                .background(Color(hex: 0x242424))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.bottom)
        }
        
    
    }
}
