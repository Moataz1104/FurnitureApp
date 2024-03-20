//
//  CartManager.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 20/03/2024.
//

import Foundation


class CartManager : ObservableObject {
    
    var cartProducts = [Product:Int]()
    
    func addToCart(product:Product){
        cartProducts[product] = 1
    }
    
}
