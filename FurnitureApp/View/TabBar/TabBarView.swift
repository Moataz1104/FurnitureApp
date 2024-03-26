//
//  TabBarView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 02/03/2024.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var navigationStateManager = NavigationStateManager(selectionPath: [AppNavigationPath]())
    var body: some View {
        
        TabView{
            HomeView()
                .tabItem { Label("", systemImage: "house") }
            
            
            FavoriteView()
                .tabItem { Label("", systemImage:"bookmark" ) }
            
            NavigationStack(path: $navigationStateManager.selectionPath){
                CartView()
                    .navigationDestination(for: AppNavigationPath.self){path in
                        switch path{
                        case .successView:
                            OrderSuccessView()
                            
                        case .checkOut(let totalCost):
                            CheckOutView(totalCost: totalCost)
                            
                        }
                    }
            }
            .tabItem{Label("", systemImage: "cart.fill")}
            .environmentObject(navigationStateManager)

            ProfileView()
                .tabItem { Label("", systemImage: "person") }
        }
        .tint(.main)

    }
}
