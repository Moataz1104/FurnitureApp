//
//  ShippingAddressView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 21/03/2024.
//

import SwiftUI

struct ShippingAddressView: View {
    @EnvironmentObject var addressManager : AddressesManager
    @State private var showingSheet = false
    @StateObject var viewModel = ShippingAddressViewModel()
    var body: some View {
        NavigationStack{
            if viewModel.userAddresses.isEmpty{
                ZStack(alignment:.bottomTrailing){
                    Image(.nodataState)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300,height: 450)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                    
                    Button{
                        viewModel.resetProperties()
                        showingSheet.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 25,height: 25)
                            .frame(width: 60,height: 60)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                        
                        
                    }
                    .padding(30)
                    .sheet(isPresented: $showingSheet){
                        SheetAddressView(viewModel: viewModel)
                    }

                }
            }else{
                ZStack(alignment:.bottomTrailing){
                    ScrollView {
                        ForEach(viewModel.userAddresses, id: \.id) { addressInfo in
                            PressToDeleteView {
                                AddressDetailView(viewModel: viewModel, addressInfo: addressInfo)
                                    .padding()
                            } onDelete: {
                                viewModel.deleteAddress(addressInfo)
                            }
                        }
                    }
                    
                    .frame(maxWidth: .infinity)
                    
                    
                    Button{
                        viewModel.resetProperties()
                        showingSheet.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 25,height: 25)
                            .frame(width: 60,height: 60)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                        
                        
                    }
                    .padding(30)
                    .sheet(isPresented: $showingSheet){
                        SheetAddressView(viewModel: viewModel)
                    }
                    
                }
                .navigationTitle("Shipping address")
                .navigationBarTitleDisplayMode(.inline)
                
            }
        }
        .onAppear{viewModel.userAddresses = addressManager.addresses}
        .onDisappear{addressManager.addresses = viewModel.userAddresses}

    }
}


struct AddressDetailView: View {
    @StateObject var viewModel : ShippingAddressViewModel
    @State var addressInfo : AddressModel
    @State var showingEditingSheet = false
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text(addressInfo.fullName)
                    .font(.system(size: 18,weight: .bold))
                Spacer()
                
                Button{
                    viewModel.oldAddress = addressInfo
                    viewModel.handleEditing()
                    showingEditingSheet.toggle()
                }label: {
                    Image(.editPen)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.black)
                }
                .sheet(isPresented: $showingEditingSheet){
                    SheetAddressView(viewModel: viewModel,editAddress: addressInfo)
                }
            }
            Divider()
            
            Text(addressInfo.address)
                .font(.system(size: 14,weight: .regular))
                .foregroundStyle(Color(hex: 0x808080))
        }
        .padding()
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
    }
    
}


struct SheetAddressView:View {
    @StateObject var viewModel : ShippingAddressViewModel
    @State var editAddress : AddressModel?

    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators:false){
                ShippingAddressInputView(
                    viewModel: viewModel,
                    text: "Full Name",
                    bindingProperty: $viewModel.fullName )
                .padding(.vertical)

                ShippingAddressInputView(
                    viewModel: viewModel,
                    text: "Address",
                    bindingProperty: $viewModel.address )
                .padding(.vertical)

                ShippingAddressInputView(
                    viewModel: viewModel,
                    text: "Zip Code",
                    bindingProperty: $viewModel.zipCode )
                .padding(.vertical)

                ShippingAddressInputView(
                    viewModel: viewModel,
                    text: "Country",
                    bindingProperty: $viewModel.country )
                .padding(.vertical)

                ShippingAddressInputView(
                    viewModel: viewModel,
                    text: "City",
                    bindingProperty: $viewModel.city )
                .padding(.vertical)
                
                ShippingAddressInputView(
                    viewModel: viewModel,
                    text: "District",
                    bindingProperty: $viewModel.district )
                .padding(.vertical)

                
                SaveView(viewModel: viewModel ,editAddress: editAddress )
                    .padding(.top,30)
            }
            .navigationTitle("Add shipping address")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ShippingAddressInputView: View {
    @StateObject var viewModel : ShippingAddressViewModel
    @State var isEditing = false
    @State var isTextEmpty = true
    @State var text : String
    @Binding var bindingProperty : String
    
    var body: some View {
        TextField("\(text)", text: $bindingProperty
                  ,onEditingChanged: { isEditing in
            if isEditing{
                self.isEditing = true
            }else{
                self.isEditing = false
            }
        })
        .frame(maxWidth: .infinity)
        .padding(.leading,15)
        .frame(height: 60)
        .background((isEditing || !isTextEmpty) ?  .white : Color(hex: 0xF5F5F5))
        .clipShape(.rect(cornerRadius: 5))
        .border((isEditing || !isTextEmpty) ? Color(hex: 0xDBDBDB) : .clear , width: 1)
        .padding(.horizontal)
        .onChange(of: bindingProperty) { oldValue, newValue in
            if newValue.isEmpty{
                isTextEmpty = true
            }else{
                isTextEmpty = false
            }
        }
    }
}


struct SaveView:View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel : ShippingAddressViewModel
    @State var editAddress : AddressModel?

    var body: some View {
        Button{
            if editAddress != nil{
                viewModel.saveEditedAddress()
            }else{
                viewModel.saveAddress()
            }
            viewModel.resetProperties()
            dismiss()
        }label: {
            Text("Save Address")
                .font(.system(size: 20,weight: .semibold))
                .padding()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(.main)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal)
        }
        .disabled(viewModel.isButtonDisabled ? false : true)
        .padding(.bottom)

    }
}



struct PressToDeleteView<Content: View>: View {
    let content: Content
    let onDelete: () -> Void

    init(@ViewBuilder content: () -> Content, onDelete: @escaping () -> Void) {
        self.content = content()
        self.onDelete = onDelete
    }

    var body: some View {
        content
            .contextMenu {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    onDelete()
                }
            }
    }
}
