//
//  OrderSuccessView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 22/03/2024.
//

import SwiftUI

struct OrderSuccessView: View {
    @EnvironmentObject var navigationStateManager: NavigationStateManager<AppNavigationPath>
    var body: some View {
        Image(.successOrder)
            .resizable()
            .scaledToFit()
            .frame(width: 300,height: 450)
        
        
        VStack{
            
            
            Button{}label: {
                Text("Track your orders")
                    .font(.system(size: 20,weight: .semibold))
                    .padding(.vertical,20)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.main)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
            }
            
            
            Button{
                navigationStateManager.popToRoot()
            }label: {
                Text("BACK TO HOME")
                    .font(.system(size: 20,weight: .semibold))
                    .padding(.vertical,20)
                    .foregroundStyle(.main)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.main, lineWidth:1)
                    }
                    .padding(.horizontal)
                
            }
            .padding(.top)
            
        }
        .padding(.bottom,40)
        .toolbar(.hidden)
        
    }
    
}

#Preview {
    OrderSuccessView()
}
