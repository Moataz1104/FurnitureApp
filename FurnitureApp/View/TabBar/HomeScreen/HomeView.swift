//
//  HomeView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 29/02/2024.
//

import SwiftUI
import NukeUI
import Foundation

struct HomeView: View {
    
    @State private var viewModel = HomeViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                HeaderView(viewModel: viewModel)
                
                ScrollView{
                    HorizontalScrollView(viewModel: viewModel)
                    

                    
                    VGridView(viewModel: viewModel)
                    
                    PaginationView(viewModel: viewModel)
                    
                    
                }
            }
            .onChange(of: viewModel.products.count) { oldValue, newValue in
                print("Products Count is \(newValue)")
            }
            .toolbar(.hidden)
        }
    }
}

//
//#Preview {
//    HomeView()
//}

struct HeaderView: View {
    @StateObject var viewModel : HomeViewModel
    @State private var isTextHidden = false
    @State private var searchText = ""
    @State private var isRotated = false
    
    var body: some View {
        HStack(alignment:.top){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                .onTapGesture {
                    withAnimation{
                        isTextHidden.toggle()
                        isRotated.toggle()
                    }
                    
                }
            Spacer()
            if !isTextHidden{
                Group{
                    VStack{
                        Text("Make Home")
                            .font(.custom("Gelasio-Regular", size: 20))
                            .foregroundStyle(Color(hex:0x909090))
                        Text("BEAUTIFUL")
                            .font(.custom("Gelasio-Bold", size: 20))
                            .foregroundStyle(.primary)
                    }
                    
                    Spacer()
                }
            }
            
            if isTextHidden{
                TextField("Search by product", text: $viewModel.fetchByKeyWord,onCommit: {
                    viewModel.products.removeAll()
                    viewModel.isUsingSearch = true
                    viewModel.fetchBySearch()
                })
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
            }
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
}

struct CategoryView: View {
    @State var text : String
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 50,height: 50)
            
                .overlay {
                    Image(systemName: text)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25,height: 25)
                        .foregroundStyle(.white)
                }
            
            
            Text(text.prefix(
                while: { $0.isASCII && $0 != "." }).capitalized)
            .font(.system(size: 16,weight: .medium))
            .padding(.top,5)
        }
        
        
    }
}

struct HorizontalScrollView: View {
    @StateObject var viewModel:HomeViewModel
    @State private var selectedIndex = 0
    
    private let catigories = ["bed.double.fill","table.furniture.fill","chair.fill" , "sofa.fill" , "lamp.desk.fill"]
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(alignment:.bottom,spacing:25){
                ForEach(Array(catigories.enumerated()),id:\.1) { index, item in
                    Button{
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.isUsingSearch = false
                            viewModel.products.removeAll()
                            selectedIndex = index
                        }
                        
                        viewModel.fetchByKeyWord = item.prefix(while: { $0.isASCII && $0 != "." }).capitalized
                        viewModel.fetchBySearch()
                        
                    }label: {
                        if !viewModel.isUsingSearch{
                            CategoryView(text: item)
                                .foregroundStyle(selectedIndex == index ? Color(hex: 0x242424) : .gray.opacity(0.5))
                        }else{
                            CategoryView(text: item)
                                .foregroundStyle(.gray.opacity(0.5))

                        }
                        
                    }
                    
                }
            }
            
        }
        .padding(.vertical,15)
        .scrollBounceBehavior(.automatic, axes: .horizontal)
        .padding(.horizontal)
    }
}

struct VGridView: View {
    @StateObject var viewModel : HomeViewModel
    let columns = [
        GridItem(.adaptive(minimum: 170)),
    ]
    var body: some View {
        ScrollView(showsIndicators: false){
//            SortingView(viewModel: viewModel)
//                .frame(maxWidth: .infinity,alignment: .leading)
//                .padding(.leading)
            
            LazyVGrid(columns: columns){
                ForEach(0..<viewModel.products.count , id:\.self) { index in
                    VStack(alignment:.leading){
                        LoadingImageView(viewModel: viewModel, product: viewModel.products[index])
                            

                        Text("$\(Int(viewModel.products[index].prices?.first?.regularPrice?.minPrice ?? 0) )")
                            .font(.system(size: 18,weight: .bold))
                            .padding(.leading)
                        
                        
                    }.padding(.vertical,16)
                    
                }
            }.onChange(of: viewModel.products.count) { oldValue, newValue in
                print(newValue)
            }

            
            .padding()
            
            
        }
    }
}


struct LoadingImageView: View {
    @StateObject var viewModel : HomeViewModel
    var product : ProductModel
    @State var starting = false
    @State private var isDest = false
    var body: some View {
        ZStack{
            ZStack(alignment:.bottomTrailing){
                LazyImage(source: URL(string: product.image?.url ?? ""))
                    .onStart({_ in starting = true})
                    .onSuccess({ _ in
                        starting = false
                    })
                    .transition(.opacity)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius:15))
                    .shadow(radius: 1)
                    .onTapGesture {
                        isDest = true
                        print("product.name")
                    }
            }
            if starting {
                ProgressView()
            }
        }.navigationDestination(isPresented: $isDest, destination: {ProductDetailView(isFav: false, productDetail: product)})
    }
    
}


struct PaginationView :View {
    @StateObject var viewModel : HomeViewModel
    var body: some View {
        if viewModel.products.isEmpty{
            ProgressView()
        }else if viewModel.products.count >= Int(viewModel.totalResults)!{
            EmptyView()
        }else{
            Button{
                viewModel.fetchMoreData()
            }label: {
                HStack(spacing:3){
                    Text("More Results")
                    
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

struct SortingView:View {
    @StateObject var viewModel : HomeViewModel
    @State private var sortingDic = ["Price ↓" : "4" , "Price ↑" : "5" ,"Highest Rated" : "6"]
    @State private var selectedSort = ""
    var body: some View {
        Picker("", selection: $selectedSort) {
            Text("All").tag("")
            ForEach(sortingDic.keys.sorted() , id:\.self){key in
                Text(key).tag(key)
            }
        }
        .onChange(of: selectedSort) { oldValue, newValue in
            viewModel.sortingId = sortingDic[selectedSort] ?? "0"
            viewModel.products.removeAll()
            viewModel.loadData()
        }
    }
}

//struct DownLoadingImageView: View {
//    @StateObject var loader:ImageLoadingViewModel
//
//    init(url: String) {
//        _loader = StateObject(wrappedValue: ImageLoadingViewModel(urlString: url))
//    }
//
//
//    var body: some View {
//        NavigationStack{
//            ZStack(alignment: .bottomTrailing){
//                if loader.isLoading{
//                    ProgressView()
//                }else if let image = loader.image{
//                    NavigationLink(destination: ProductDetailView()) {
//                        
//                        
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .clipShape(RoundedRectangle(cornerRadius:15))
//                            .shadow(radius: 3)
//                    }
//                    
//                    Button{}label: {
//                        Image("shopping_bag icon")
//                            .resizable()
//                            .foregroundStyle(.white)
//                            .frame(width: 20,height: 20)
//                            .frame(width: 30,height: 30)
//                            .background(RoundedRectangle(
//                                cornerRadius: 10)
//                                .foregroundStyle(
//                                    Color(hex: 0x606060).opacity(0.4)))
//                            .padding()
//                    }
//                }
//            }
//        }
//    }
//}
