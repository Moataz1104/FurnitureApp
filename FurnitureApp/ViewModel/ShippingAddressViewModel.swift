//
//  ShippingAddressViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 21/03/2024.
//

import Foundation

class ShippingAddressViewModel:ObservableObject {
    
    @Published var userAddresses = [AddressModel]()
    
    @Published var fullName : String = ""
    @Published var address : String = ""
    @Published var zipCode : String = ""
    @Published var country : String = ""
    @Published var city : String = ""
    @Published var district : String = ""
    @Published var isAddressActive : Bool = false
    
    @Published var oldAddress : AddressModel?
    
    
    

    
    var isButtonDisabled : Bool {
        
       return !fullName.isEmpty && !address.isEmpty && !zipCode.isEmpty && !country.isEmpty && !city.isEmpty && !district.isEmpty
    }
    
    func resetProperties(){
         fullName  = ""
         address  = ""
         zipCode  = ""
         country  = ""
         city  = ""
         district  = ""
         isAddressActive  = false
    }
    
    func saveAddress(){
        let newAddress = AddressModel(id: UUID() , fullName: fullName, address: address, zipCode: zipCode, country: country, city: city, district: district, isAddressActive: false)
        
        userAddresses.append(newAddress)
        
        print("saveFunc : \(userAddresses.count)")

    }
    
    
    func saveEditedAddress(){
        print("saveEditFunc111 : \(oldAddress?.fullName ?? "No Data111")")
        if let index = userAddresses.firstIndex(where: { $0.id == oldAddress?.id }) {
            var editingAddress = userAddresses[index]
            
            editingAddress.fullName = fullName
            editingAddress.address = address
            editingAddress.zipCode = zipCode
            editingAddress.country = country
            editingAddress.city = city
            editingAddress.district = district
            editingAddress.id = UUID()
            userAddresses[index] = editingAddress
        }
        
    }

    
    func handleEditing(){
        guard let oldAddress = oldAddress else { return}
        fullName  = oldAddress.fullName
        address  = oldAddress.address
        zipCode  = oldAddress.zipCode
        country  = oldAddress.country
        city  = oldAddress.city
        district  = oldAddress.district
        isAddressActive  = oldAddress.isAddressActive
    }

    
    func deleteAddress(_ address:AddressModel) {
        if let index = userAddresses.firstIndex(where: {$0.id == address.id}){
            userAddresses.remove(at: index)
        }
    }
}
