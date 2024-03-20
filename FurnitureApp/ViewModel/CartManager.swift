//
//  CartManager.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 20/03/2024.
//

import Foundation


class CartManager : ObservableObject {
    
    var cartProducts = [Product]()
    
    func addToCart(product:Product){
        cartProducts.append(product)
        print("Cart Manager : \(cartProducts.count)")
    }
    
}
