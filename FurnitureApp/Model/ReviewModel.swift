//
//  dd.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 13/03/2024.
//


import Foundation

struct ReviewPayload: Codable {
    let payload: ReviewData?
}

struct ReviewData: Codable {
    let results: [ReviewResult]?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case results = "Results"
        case totalResults = "TotalResults"
    }
}

struct ReviewResult: Codable {
    let userNickname: String?
    let rating: Int?
    let reviewText: String?
    let lastModificationTime: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case userNickname = "UserNickname"
        case reviewText = "ReviewText"
        case rating = "Rating"
        case lastModificationTime = "LastModificationTime"
        case title = "Title"

    }
    
    var formattedLastModificationTime: String? {
        guard let lastModificationTime = lastModificationTime else { return nil }
        let originalDateFormatter = DateFormatter()
        originalDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let date = originalDateFormatter.date(from: lastModificationTime) else { return nil }
        
        return outputDateFormatter.string(from: date)
    }
}
