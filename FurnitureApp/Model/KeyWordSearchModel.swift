//
//  KeyWordSearchModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 04/03/2024.
//

import Foundation


struct KeyWordSearchModel :Codable {
    let payload : PayLoad
    let count:Int
    let limit : Int
    let offset : Int
}


struct PayLoad : Codable {
    let products : [ProductModel]?
}




struct ProductModel: Codable  {
    
    let webID : String
    let productTitle: String?
    let image: ImageCoding?
    let prices: [Price]?
    let rating: Rating?
    let swatchImages: [SwatchImage]?
    let seoURL, variations: String?
    let altImageURL: String?
    let prodType: String?
    let displayColor, availableColr: [String]?
    let isAvailableforShip, isAvailableforPickUp, boosted, ypEligible: Bool?
    let sephoraProduct: Bool?
    let couponEligible, isVGC: Bool?
    
    
}

struct ImageCoding: Codable {
    let url: String?
    let height, width: String?
}

struct Price: Codable {
    let regularPrice: RegularPrice?
}


struct RegularPrice: Codable {
    let minPrice: Double?
}

struct Rating: Codable {
    let avgRating: Double?
    let count: Int?
}

struct SwatchImage: Codable {
    let color: String?
    let url: String?

}




//struct KeyWordSearchModel: Codable {
//    let id: String
//    let name: String
//    let price: Price
//    let typeName: String
//    let image: String
//    let contextualImageUrl: String?
//    let imageAlt: String
//    let url: String
//    let variants: [Variant]?
//}
//
//struct Price: Codable {
//    let currency: String
//    let currentPrice: Double
//    let discounted: Bool
//}
//
////struct Category: Codable {
////    let name: String
////    let key: String
////}
//
//struct Variant: Codable {
//    let id: String
//    let name: String
//    let price: Price
////    let measurement: String
//    let typeName: String
//    let image: String
//    let contextualImageUrl: String?
//    let imageAlt: String
//    let url: String
//}
