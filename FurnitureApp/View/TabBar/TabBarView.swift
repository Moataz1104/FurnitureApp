//
//  TabBarView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 02/03/2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem { Label("", systemImage: "house") }
            
            
            FavoriteView()
                .tabItem { Label("", systemImage:"bookmark" ) }
                .toolbarBackground(Color.black, for: .tabBar)
            
            
            StoresMapView()
                .tabItem{Label("", systemImage: "location.circle")}
            
            ProfileView()
                .tabItem { Label("", systemImage: "person") }

        }.onAppear{
            UITabBar.appearance().backgroundColor = .white
        }
        .tint(.black)
    }
}

#Preview {
    TabBarView()
}
