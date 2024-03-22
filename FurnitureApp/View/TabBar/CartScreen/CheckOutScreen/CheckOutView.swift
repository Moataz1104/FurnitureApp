//
//  CheckOutView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 22/03/2024.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var addressManager : AddressesManager
    @State var totalCost:String
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators:false){
                CheckOutAddressView()
                    .padding(.vertical)
                
                PaymentView()
                    .padding(.vertical)
                
                
                
                DeliveryMethodView()
                    .padding(.vertical)
                
                InvoiceView(totalCost: totalCost)
                    .padding(.bottom)
            }
            .navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)

            
        }
    }
}

struct CheckOutAddressView: View {
    @EnvironmentObject var addressManager : AddressesManager
    @State var showingAddressesSheet = false
    var body: some View {
        VStack(alignment:.leading) {
            Text("Shipping Address")
                .font(.system(size: 18,weight: .semibold))
                .foregroundStyle(Color(hex: 0x909090))
                .padding(.leading)
            
            VStack(alignment:.leading){
                HStack{
                    Text(addressManager.chosenAddress?.fullName ?? addressManager.addresses.first?.fullName ?? "No Address")
                        .font(.system(size: 18,weight: .bold))
                    Spacer()
                    
                    if (!addressManager.addresses.isEmpty) && (addressManager.addresses.count > 1){
                        
                        
                        Button{
                            showingAddressesSheet.toggle()
                        }label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                                .foregroundStyle(.black)
                        }
                        .sheet(isPresented: $showingAddressesSheet){
                            AddressesSheet()
                        }
                    }
                }
                Divider()
                
                Text(addressManager.chosenAddress?.address ?? addressManager.addresses.first?.address ?? "Go to Shipping Addresses and create new address")
                    .font(.system(size: 14,weight: .regular))
                    .foregroundStyle(Color(hex: 0x808080))
            }
            .padding()
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 3)
            .padding(.horizontal)
        }
    }
}



struct AddressesSheet:View {
    @EnvironmentObject var addressManager : AddressesManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(addressManager.addresses){address in
                    AddressSampleView(address: address)
                        .padding(.vertical)
                        .onTapGesture {
                            addressManager.chosenAddress = address
                            dismiss()
                        }
                }
            }
            .navigationTitle("Choose Address")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




struct AddressSampleView:View {
    @State var address:AddressModel
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text(address.fullName)
                    .font(.system(size: 18,weight: .bold))
                Spacer()
                
            }
            Divider()
            
            Text(address.address)
                .font(.system(size: 14,weight: .regular))
                .foregroundStyle(Color(hex: 0x808080))
        }
        .padding()
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
        .padding(.horizontal)

    }
}



struct PaymentView:View {
    var body: some View {
        VStack(alignment:.leading){
            Text("Payment")
                .font(.system(size: 18,weight: .semibold))
                .foregroundStyle(Color(hex: 0x909090))
            
            HStack{
                Image(.mastercard)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50,height: 30)
                    .frame(width: 70,height: 50)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 15))
                    .shadow(radius: 3)
                
                    
                Text("**** **** **** 3947")
                    .font(.system(size: 18,weight: .semibold))
                
                Spacer()
            }
            .padding(.horizontal)
            .frame(height: 80)
            .background(.white)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 3)
            
        }
        .padding(.horizontal)
    }
}


struct DeliveryMethodView:View {
    var body: some View {
        VStack(alignment:.leading){
            Text("Delivery Method")
                .font(.system(size: 18,weight: .semibold))
                .foregroundStyle(Color(hex: 0x909090))
            
            HStack{
                Image(.dhl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110,height: 40)
                
                    
                Text("Fast (2-3days)")
                    .font(.system(size: 18,weight: .bold))
                
                Spacer()
            }
            .padding(.horizontal)
            .frame(height: 80)
            .background(.white)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 3)
            
        }
        .padding(.horizontal)

    }
}

#Preview {
    InvoiceView(totalCost: "95")
}


struct InvoiceView:View {
    @State var totalCost:String
    var body: some View {
        VStack(spacing:20){
            VStack(spacing:20){
                HStack{
                    Text("Order:")
                        .font(.system(size: 18,weight: .regular))
                        .foregroundStyle(Color(hex: 0x808080))
                    Spacer()
                    Text("$ \(totalCost)")
                        .font(.system(size: 17,weight: .semibold))
                }
                .padding(.top)
                HStack{
                    Text("Order:")
                        .font(.system(size: 18,weight: .regular))
                        .foregroundStyle(Color(hex: 0x808080))
                    Spacer()
                    Text("$ 50")
                        .font(.system(size: 17,weight: .semibold))

                }
                
                HStack{
                    Text("Order:")
                        .font(.system(size: 18,weight: .regular))
                        .foregroundStyle(Color(hex: 0x808080))
                    Spacer()
                    Text("$ \(Int(totalCost)! + 50)")
                        .font(.system(size: 18,weight: .bold))

                }
                .padding(.bottom)
                
            }
            .padding(.horizontal)
            .background(.white)
            .shadow(radius: 10)
            .padding(.horizontal)
            
            Button{}label: {
                Text("SUBMIT ORDER")
                    .font(.system(size: 20,weight: .semibold))
                    .padding()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.main)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)

            }
        }
    }
}
