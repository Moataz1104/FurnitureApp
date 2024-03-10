//
//  ProductDetailModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 07/03/2024.
//

import Foundation


struct ProductDetailModel: Codable {
    let payload: Payload
    let count, limit, offset: Int?
}

struct Payload: Codable {
    let products: [Product]?
}

struct Product: Codable {
    let description: Description?
    let webID: String?
    let price: ProductPrice?
    let images: [ImageDetails]?
    let brand, brandSEOURL: String?
    let swatchImages: [SwatchImage]?
    let productStatus, productTitle: String?
    let productURL: String?
    let avgRating: String?
    let ratingCount, recommendedPercentage: Int?
    let bestSeller, topRated: Bool?
    let metaInfo: [MetaInfo]?
    let seoURL: String?
    let exclusions: Description?
    let altImages: [ImageDetails]?
    let isBopusEligible: Bool?
    let monetization: [String: Monetization?]?
    let monetizationAttributes: MonetizationAttributes?
    let isLTLProduct, isMarketplaceItem: Bool?
    let shippingAndReturn: String?
    let preSelectedColor, preSelectedSku: String?
    let taxCode: String?
    let isNew: Bool?
    let defaultAccordion: String?
    let productFeatureCode, productDetails: String?
    let relatedInformation: String?
    let availableAccordions: [String]?
    let maxQuantityMessage, itemMaxAvailableCount: String?
    let partnership: String?
    let dept: String?
    let allSkusAvailableOnline, isBossEligible: Bool?
    let ypEligibility: String?
    let isStoreAvailable, kcEligible: Bool?
    let priceSet: [Double]?
    let breadcrumbs: [Breadcrumb]?
    
    
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
