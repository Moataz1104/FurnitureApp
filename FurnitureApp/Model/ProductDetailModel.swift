//
//  ProductDetailModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 07/03/2024.
//

import Foundation
import SwiftData

struct ProductDetailModel: Codable {
    let payload: Payload
    let count, limit, offset: Int?
}

struct Payload: Codable {
    let products: [Product]?
}

@Model
class Product: Codable {
    let productDescription: Description?
    let webID: String?
    let price: ProductPrice?
    let images: [ImageDetails]?
    let brand:String?
    let brandSEOURL: String?
    let swatchImages: [SwatchImage]?
    let productStatus: String?
    let productTitle: String?
    let productURL: String?
    let avgRating: String?
    let ratingCount: Int?
    let recommendedPercentage: Int?
    let bestSeller: Bool?
    let topRated: Bool?
    let metaInfo: [MetaInfo]?
    let seoURL: String?
    let exclusions: Description?
    let altImages: [ImageDetails]?
    let isBopusEligible: Bool?
    let monetization: [String: Monetization?]?
    let monetizationAttributes: MonetizationAttributes?
    let isLTLProduct: Bool?
    let isMarketplaceItem: Bool?
    let shippingAndReturn: String?
    let preSelectedColor: String?
    let preSelectedSku: String?
    let taxCode: String?
    let isNew: Bool?
    let defaultAccordion: String?
    let productFeatureCode: String?
    let productDetails: String?
    let relatedInformation: String?
    let availableAccordions: [String]?
    let maxQuantityMessage: String?
    let itemMaxAvailableCount: String?
    let partnership: String?
    let dept: String?
    let allSkusAvailableOnline: Bool?
    let isBossEligible: Bool?
    let ypEligibility: String?
    let isStoreAvailable:Bool?
    let kcEligible: Bool?
    let priceSet: [Double]?
    let breadcrumbs: [Breadcrumb]?
    private enum CodingKeys: String, CodingKey {
        case productDescription = "description"
        case webID
        case price
        case images
        case brand
        case brandSEOURL
        case swatchImages
        case productStatus
        case productTitle
        case productURL
        case avgRating
        case ratingCount
        case recommendedPercentage
        case bestSeller
        case topRated
        case metaInfo
        case seoURL
        case exclusions
        case altImages
        case isBopusEligible
        case monetization
        case monetizationAttributes
        case isLTLProduct
        case isMarketplaceItem
        case shippingAndReturn
        case preSelectedColor
        case preSelectedSku
        case taxCode
        case isNew
        case defaultAccordion
        case productFeatureCode
        case productDetails
        case relatedInformation
        case availableAccordions
        case maxQuantityMessage
        case itemMaxAvailableCount
        case partnership
        case dept
        case allSkusAvailableOnline
        case isBossEligible
        case ypEligibility
        case isStoreAvailable
        case kcEligible
        case priceSet
        case breadcrumbs
    }

    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.productDescription = try container.decodeIfPresent(Description.self, forKey: .productDescription)
        self.webID = try container.decodeIfPresent(String.self, forKey: .webID)
        self.price = try container.decodeIfPresent(ProductPrice.self, forKey: .price)
        self.images = try container.decodeIfPresent([ImageDetails].self, forKey: .images)
        self.brand = try container.decodeIfPresent(String.self, forKey: .brand)
        self.brandSEOURL = try container.decodeIfPresent(String.self, forKey: .brandSEOURL)
        self.swatchImages = try container.decodeIfPresent([SwatchImage].self, forKey: .swatchImages)
        self.productStatus = try container.decodeIfPresent(String.self, forKey: .productStatus)
        self.productTitle = try container.decodeIfPresent(String.self, forKey: .productTitle)
        self.productURL = try container.decodeIfPresent(String.self, forKey: .productURL)
        self.avgRating = try container.decodeIfPresent(String.self, forKey: .avgRating)
        self.ratingCount = try container.decodeIfPresent(Int.self, forKey: .ratingCount)
        self.recommendedPercentage = try container.decodeIfPresent(Int.self, forKey: .recommendedPercentage)
        self.bestSeller = try container.decodeIfPresent(Bool.self, forKey: .bestSeller)
        self.topRated = try container.decodeIfPresent(Bool.self, forKey: .topRated)
        self.metaInfo = try container.decodeIfPresent([MetaInfo].self, forKey: .metaInfo)
        self.seoURL = try container.decodeIfPresent(String.self, forKey: .seoURL)
        self.exclusions = try container.decodeIfPresent(Description.self, forKey: .exclusions)
        self.altImages = try container.decodeIfPresent([ImageDetails].self, forKey: .altImages)
        self.isBopusEligible = try container.decodeIfPresent(Bool.self, forKey: .isBopusEligible)
        self.monetization = try container.decodeIfPresent([String: Monetization?].self, forKey: .monetization)
        self.monetizationAttributes = try container.decodeIfPresent(MonetizationAttributes.self, forKey: .monetizationAttributes)
        self.isLTLProduct = try container.decodeIfPresent(Bool.self, forKey: .isLTLProduct)
        self.isMarketplaceItem = try container.decodeIfPresent(Bool.self, forKey: .isMarketplaceItem)
        self.shippingAndReturn = try container.decodeIfPresent(String.self, forKey: .shippingAndReturn)
        self.preSelectedColor = try container.decodeIfPresent(String.self, forKey: .preSelectedColor)
        self.preSelectedSku = try container.decodeIfPresent(String.self, forKey: .preSelectedSku)
        self.taxCode = try container.decodeIfPresent(String.self, forKey: .taxCode)
        self.isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew)
        self.defaultAccordion = try container.decodeIfPresent(String.self, forKey: .defaultAccordion)
        self.productFeatureCode = try container.decodeIfPresent(String.self, forKey: .productFeatureCode)
        self.productDetails = try container.decodeIfPresent(String.self, forKey: .productDetails)
        self.relatedInformation = try container.decodeIfPresent(String.self, forKey: .relatedInformation)
        self.availableAccordions = try container.decodeIfPresent([String].self, forKey: .availableAccordions)
        self.maxQuantityMessage = try container.decodeIfPresent(String.self, forKey: .maxQuantityMessage)
        self.itemMaxAvailableCount = try container.decodeIfPresent(String.self, forKey: .itemMaxAvailableCount)
        self.partnership = try container.decodeIfPresent(String.self, forKey: .partnership)
        self.dept = try container.decodeIfPresent(String.self, forKey: .dept)
        self.allSkusAvailableOnline = try container.decodeIfPresent(Bool.self, forKey: .allSkusAvailableOnline)
        self.isBossEligible = try container.decodeIfPresent(Bool.self, forKey: .isBossEligible)
        self.ypEligibility = try container.decodeIfPresent(String.self, forKey: .ypEligibility)
        self.isStoreAvailable = try container.decodeIfPresent(Bool.self, forKey: .isStoreAvailable)
        self.kcEligible = try container.decodeIfPresent(Bool.self, forKey: .kcEligible)
        self.priceSet = try container.decodeIfPresent([Double].self, forKey: .priceSet)
        self.breadcrumbs = try container.decodeIfPresent([Breadcrumb].self, forKey: .breadcrumbs)
    }

    init(
        productDescription: Description?,
        webID: String?,
        price: ProductPrice?,
        images: [ImageDetails]?,
        brand: String?,
        brandSEOURL: String?,
        swatchImages: [SwatchImage]?,
        productStatus: String?,
        productTitle: String?,
        productURL: String?,
        avgRating: String?,
        ratingCount: Int?,
        recommendedPercentage: Int?,
        bestSeller: Bool?,
        topRated: Bool?,
        metaInfo: [MetaInfo]?,
        seoURL: String?,
        exclusions: Description?,
        altImages: [ImageDetails]?,
        isBopusEligible: Bool?,
        monetization: [String : Monetization?]?,
        monetizationAttributes: MonetizationAttributes?,
        isLTLProduct: Bool?,
        isMarketplaceItem: Bool?,
        shippingAndReturn: String?,
        preSelectedColor: String?,
        preSelectedSku: String?,
        taxCode: String?,
        isNew: Bool?,
        defaultAccordion: String?,
        productFeatureCode: String?,
        productDetails: String?,
        relatedInformation: String?,
        availableAccordions: [String]?,
        maxQuantityMessage: String?,
        itemMaxAvailableCount: String?,
        partnership: String?,
        dept: String?,
        allSkusAvailableOnline: Bool?,
        isBossEligible: Bool?,
        ypEligibility: String?,
        isStoreAvailable: Bool?,
        kcEligible: Bool?,
        priceSet: [Double]?,
        breadcrumbs: [Breadcrumb]?
    ) {
        self.productDescription = productDescription
        self.webID = webID
        self.price = price
        self.images = images
        self.brand = brand
        self.brandSEOURL = brandSEOURL
        self.swatchImages = swatchImages
        self.productStatus = productStatus
        self.productTitle = productTitle
        self.productURL = productURL
        self.avgRating = avgRating
        self.ratingCount = ratingCount
        self.recommendedPercentage = recommendedPercentage
        self.bestSeller = bestSeller
        self.topRated = topRated
        self.metaInfo = metaInfo
        self.seoURL = seoURL
        self.exclusions = exclusions
        self.altImages = altImages
        self.isBopusEligible = isBopusEligible
        self.monetization = monetization
        self.monetizationAttributes = monetizationAttributes
        self.isLTLProduct = isLTLProduct
        self.isMarketplaceItem = isMarketplaceItem
        self.shippingAndReturn = shippingAndReturn
        self.preSelectedColor = preSelectedColor
        self.preSelectedSku = preSelectedSku
        self.taxCode = taxCode
        self.isNew = isNew
        self.defaultAccordion = defaultAccordion
        self.productFeatureCode = productFeatureCode
        self.productDetails = productDetails
        self.relatedInformation = relatedInformation
        self.availableAccordions = availableAccordions
        self.maxQuantityMessage = maxQuantityMessage
        self.itemMaxAvailableCount = itemMaxAvailableCount
        self.partnership = partnership
        self.dept = dept
        self.allSkusAvailableOnline = allSkusAvailableOnline
        self.isBossEligible = isBossEligible
        self.ypEligibility = ypEligibility
        self.isStoreAvailable = isStoreAvailable
        self.kcEligible = kcEligible
        self.priceSet = priceSet
        self.breadcrumbs = breadcrumbs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(productDescription, forKey: .productDescription)
        try container.encode(webID, forKey: .webID)
        try container.encode(price, forKey: .price)
        try container.encode(images, forKey: .images)
        try container.encode(brand, forKey: .brand)
        try container.encode(brandSEOURL, forKey: .brandSEOURL)
        try container.encode(swatchImages, forKey: .swatchImages)
        try container.encode(productStatus, forKey: .productStatus)
        try container.encode(productTitle, forKey: .productTitle)
        try container.encode(productURL, forKey: .productURL)
        try container.encode(avgRating, forKey: .avgRating)
        try container.encode(ratingCount, forKey: .ratingCount)
        try container.encode(recommendedPercentage, forKey: .recommendedPercentage)
        try container.encode(bestSeller, forKey: .bestSeller)
        try container.encode(topRated, forKey: .topRated)
        try container.encode(metaInfo, forKey: .metaInfo)
        try container.encode(seoURL, forKey: .seoURL)
        try container.encode(exclusions, forKey: .exclusions)
        try container.encode(altImages, forKey: .altImages)
        try container.encode(isBopusEligible, forKey: .isBopusEligible)
        try container.encode(monetization, forKey: .monetization)
        try container.encode(monetizationAttributes, forKey: .monetizationAttributes)
        try container.encode(isLTLProduct, forKey: .isLTLProduct)
        try container.encode(isMarketplaceItem, forKey: .isMarketplaceItem)
        try container.encode(shippingAndReturn, forKey: .shippingAndReturn)
        try container.encode(preSelectedColor, forKey: .preSelectedColor)
        try container.encode(preSelectedSku, forKey: .preSelectedSku)
        try container.encode(taxCode, forKey: .taxCode)
        try container.encode(isNew, forKey: .isNew)
        try container.encode(defaultAccordion, forKey: .defaultAccordion)
        try container.encode(productFeatureCode, forKey: .productFeatureCode)
        try container.encode(productDetails, forKey: .productDetails)
        try container.encode(relatedInformation, forKey: .relatedInformation)
        try container.encode(availableAccordions, forKey: .availableAccordions)
        try container.encode(maxQuantityMessage, forKey: .maxQuantityMessage)
        try container.encode(itemMaxAvailableCount, forKey: .itemMaxAvailableCount)
        try container.encode(partnership, forKey: .partnership)
        try container.encode(dept, forKey: .dept)
        try container.encode(allSkusAvailableOnline, forKey: .allSkusAvailableOnline)
        try container.encode(isBossEligible, forKey: .isBossEligible)
        try container.encode(ypEligibility, forKey: .ypEligibility)
        try container.encode(isStoreAvailable, forKey: .isStoreAvailable)
        try container.encode(kcEligible, forKey: .kcEligible)
        try container.encode(priceSet, forKey: .priceSet)
        try container.encode(breadcrumbs, forKey: .breadcrumbs)
    }

    
    
    var allImages: [ImageDetails]? {
        var combinedImages: [ImageDetails] = []
        if let images = images {
            combinedImages.append(contentsOf: images)
        }
        if let altImages = altImages {
            combinedImages.append(contentsOf: altImages)
        }
        return combinedImages.isEmpty ? nil : combinedImages
    }

}

struct ImageDetails: Codable , Hashable {
    let url: String?
    let height, width, altText: String?
    
    var newUrl : String? {
        if let urlString = url {
            var urlComponents = URLComponents(string: urlString)
            var queryItems = urlComponents!.queryItems
            queryItems?.removeAll(where: {$0.name == "wid" || $0.name == "hei"})
            queryItems?.append(URLQueryItem(name: "wid", value: "400"))
            queryItems?.append(URLQueryItem(name: "hei", value: "400"))
            urlComponents?.queryItems = queryItems
            return urlComponents?.string
        }
        return nil
    }
}

struct Breadcrumb: Codable {
    let name, seoURL, currentDimensionID: String?
}

struct Description: Codable {
    let shortDescription: String?
    let longDescription: String?
    }

struct MetaInfo: Codable {
    let metaTitle, metaDescription: String?
}

struct Monetization: Codable {
    let value: String?
}

struct MonetizationAttributes: Codable {
    let ageAppropriate: String?
    let sizeRange: String?
}

struct ProductPrice: Codable {
    let regularPrice: RegularPricing?
}


struct RegularPricing: Codable {
    let minPrice: Double?
}


struct PriceDetail: Codable {
    let minPrice: Double?
}


struct SwatchImageDetails: Codable {
    let color: String?
    let url: String?
}
