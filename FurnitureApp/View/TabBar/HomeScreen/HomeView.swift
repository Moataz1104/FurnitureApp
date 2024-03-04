//
//  HomeView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 29/02/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            HeaderView()
            
            ScrollView{
                HorizontalScrollView()
                
                VGridView()
            }
            
            
            
        }
    }
}

#Preview {
    HomeView()
}

struct HeaderView: View {
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
                    Image(systemName: "cart")
                        .font(.title2)
                }
            }
            
            if isTextHidden{
                TextField("Search by product", text: $searchText)
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
    private let catigories = ["chair.fill" , "table.furniture.fill" , "sofa.fill" , "lamp.desk.fill","bed.double.fill"]
    @State private var selectedIndex = 0

    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(alignment:.bottom,spacing:25){
                ForEach(Array(catigories.enumerated()),id:\.1) { index, item in
                    Button{
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedIndex = index
                        }
                    }label: {
                        CategoryView(text: item)
                            .foregroundStyle(selectedIndex == index ? Color(hex: 0x242424) : .gray.opacity(0.5))
                        
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
    let columns = [
           GridItem(.adaptive(minimum: 180))
       ]

    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVGrid(columns: columns){
                ForEach(0..<20){ _ in
                    VStack(alignment:.leading){
                        ZStack(alignment:.bottomTrailing){
                            Image(.test)
                                .resizable()
                                .scaledToFit()
                            Button{}label: {
                                Image("shopping_bag icon")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .frame(width: 20,height: 20)
                                    .frame(width: 30,height: 30)
                                    .background(RoundedRectangle(
                                        cornerRadius: 10)
                                        .foregroundStyle(
                                            Color(hex: 0x606060).opacity(0.4)))
                                    .padding()
                            }
                            
                        }
                        Text("Black Simple Lamp")
                        Text("$ 12.00")
                    }.padding()
                }
            }
        }
    }
}
