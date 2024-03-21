//
//  AddressModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 21/03/2024.
//

import Foundation
 
struct AddressModel :Identifiable {
    var id: UUID
    var fullName : String
    var address : String
    var zipCode : String
    var country : String
    var city : String
    var district : String
    var isAddressActive : Bool
}
