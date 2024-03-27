//
//  ProfileView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 02/03/2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel : AuthManager
    
    @State private var profileArray = ["My orders","Shipping Addresses","Payment Method","My reviews","Setting"]
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:40){
                    ProfileDetailsView()
                    
                    VStack(spacing:30){
                        ForEach(profileArray , id:\.self) { text in
                            NavigationLink(destination: ShippingAddressView()) {
                                ProfileFormView(text: text)
                            }
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
    tst()
}


struct tst:View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?

    var body: some View {
        
        
        HStack(spacing:20){
            Group{
                if let avatarImage = avatarImage {
                    avatarImage
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 100,height: 100)
                    
                }else{
                    Image(systemName: "photo.badge.plus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 100)
                }
            }
            .overlay{
                PhotosPicker(selection: $avatarItem,matching: .images) {
                    Rectangle()
                        .frame(width: 100,height: 100)
                        .foregroundStyle(.clear)
                }
                .onChange(of: avatarItem) {
                    Task {
                        if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                            avatarImage = loaded
                        } else {
                            print("Failed")
                        }
                    }
                }
            }
            
            VStack(alignment:.leading){
                Text("userName ?? ")
                    .font(.system(size: 20,weight: .bold))
                    .foregroundStyle(.main)
                
                Text("viewModel.user?.email ?? ")
                    .font(.system(size: 18,weight: .regular))
                    .tint(.subMain)
                
            }
            Spacer()
        }
        .padding()

    }
}



struct ProfileDetailsView: View {
    @EnvironmentObject private var viewModel : AuthManager
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?

    @State var userName : String?
    var body: some View {
        HStack(spacing:20){
            Group{
                if let avatarImage = avatarImage {
                    avatarImage
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 100,height: 100)
                    
                }else{
                    Image(systemName: "photo.badge.plus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 100)
                }
            }
            .overlay{
                PhotosPicker(selection: $avatarItem,matching: .images) {
                    Rectangle()
                        .frame(width: 100,height: 100)
                        .foregroundStyle(.clear)
                }
                .onChange(of: avatarItem) {
                    Task {
                        if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                            avatarImage = loaded
                        } else {
                            print("Failed")
                        }
                    }
                }
            }
            VStack(alignment:.leading){
                Text(userName ?? "")
                    .font(.system(size: 20,weight: .bold))
                    .foregroundStyle(.main)
                
                Text(viewModel.user?.email ?? "")
                    .font(.system(size: 18,weight: .regular))
                    .tint(.subMain)
                
            }
            Spacer()
        }
        .padding()
        .onAppear{
            viewModel.getUsername(forUserID: viewModel.user?.uid ?? "") { userName in
                self.userName = userName
            }
        }

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
