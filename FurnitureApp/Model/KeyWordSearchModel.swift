//
//  KeyWordSearchModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 04/03/2024.
//

import Foundation

struct KeyWordSearchModel: Codable {
    let id: String
    let name: String
    let price: Price
    let typeName: String
    let image: String
    let contextualImageUrl: String?
    let imageAlt: String
    let url: String
    let variants: [Variant]?
}

struct Price: Codable {
    let currency: String
    let currentPrice: Double
    let discounted: Bool
}

//struct Category: Codable {
//    let name: String
//    let key: String
//}

struct Variant: Codable {
    let id: String
    let name: String
    let price: Price
//    let measurement: String
    let typeName: String
    let image: String
    let contextualImageUrl: String?
    let imageAlt: String
    let url: String
}
