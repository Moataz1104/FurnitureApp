//
//  AddressesManager.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 22/03/2024.
//

import Foundation

class AddressesManager : ObservableObject {
    @Published var addresses = [AddressModel]()
    
    
    @Published var chosenAddress:AddressModel?
    
    
}
