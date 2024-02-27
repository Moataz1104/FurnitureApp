//
//  ContentView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 22/02/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Image(.splash)
                    .resizable()
                    .scaledToFill()
                VStack(spacing:100){
                    VStack(alignment:.leading,spacing:15){
                        Text("MAKE YOUR")
                            .font(.custom("Gelasio-SemiBold", size: 29))
                            .foregroundStyle(.subMain)
                        Text("HOME BEAUTIFUL")
                            .font(.custom("Gelasio-Bold", size: 35))
                            .foregroundStyle(.main)
                        Text("The best simple place where you\n discover most wonderful furnitures\n and make your home beautiful")
                            .foregroundStyle(.subTitle)
                            .font(.custom("Gelasio-Regular", size: 20))
                    }
                    
                    NavigationLink(destination: LogInView()) {
                            Rectangle()
                                .frame(width: 160,height: 60)
                                .foregroundStyle(.main)
                                .overlay{
                                    Text("Get Started")
                                        .font(.custom("Gelasio-SemiBold", size: 20))
                                        .foregroundStyle(.white)
                                }
                        }
                        .offset(y:100)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView()
}
