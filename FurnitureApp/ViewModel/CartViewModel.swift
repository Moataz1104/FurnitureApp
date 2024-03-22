//
//  CartViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 19/03/2024.
//

import Foundation

class CartViewModel : ObservableObject {
    
    @Published var cartProducts = [Product:Int]()
    
    var totalCost:String{
        var cost = 0
        for (product,multiplier) in cartProducts {
            cost += Int(product.price?.regularPrice?.minPrice ?? 0) * multiplier
        }
        
        return "\(cost)"
    }
}
