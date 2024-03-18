//
//  ProfileView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 02/03/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel : AuthViewModel
    
    @State private var profileArray = ["My orders","Shipping Addresses","Payment Method","My reviews","Setting"]
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:40){
                    ProfileDetailsView()
                    
                    VStack(spacing:30){
                        ForEach(profileArray , id:\.self) { text in
                            ProfileFormView(text: text)
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button{
                        viewModel.signOut()
                    }label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .tint(.main)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}

struct ProfileDetailsView: View {
    var body: some View {
        HStack(spacing:20){
            Image(.moataz)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 100,height: 100)
            
            VStack(alignment:.leading){
                Text("Moataz Mohamed")
                    .font(.system(size: 20,weight: .bold))
                    .foregroundStyle(.main)
                
                Text("Moataz@gmail.com")
                    .font(.system(size: 18,weight: .regular))
                    .tint(.subMain)
                
            }
            Spacer()
        }.padding()
    }
}

struct ProfileFormView: View {
    @State var text : String

    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width * 0.9,height: 65)
            .foregroundStyle(.white)
            .shadow(radius: 3)
            .overlay{
                HStack{
                    Text(text)
                        .font(.system(size: 18,weight: .bold))
                    Spacer()
                    Image(systemName: "chevron.forward")
                }.padding(.horizontal)
            }
        
    }
}
