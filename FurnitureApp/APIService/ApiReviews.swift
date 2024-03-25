//
//  ApiReviews.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 13/03/2024.
//

import Foundation


class ApiReviews{
    
    
    static let shared = ApiReviews()
    private init(){}

    
    private let apiKey = "0eba5408f5mshb9937614eee1533p143095jsna5a04c8b6496"
    private let urlString = "https://kohls.p.rapidapi.com/reviews/list"
    
    func fetchReviews(id : String,offset:String = "0") async throws -> ReviewData?{
        let params = ["ProductId" : id , "Limit" : "25","Offset":offset]
        
        guard let url = URL(string: urlString) 
        else{print("Invalid Reviews url"); return nil}
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
        
        guard let finalUrl = urlComponents?.url 
        else{print("Invalid Final Reviews Url") ; return nil}

        
        var request = URLRequest(url: finalUrl)
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("kohls.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        let (data , response) = try await URLSession.shared.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 200
        else{print("Reviews response error \(response)") ; return nil}

        
        
        guard let decodedData = try? JSONDecoder().decode(ReviewPayload.self, from: data)
        else{print("Reviews Decoding failed") ; return nil }
        
        
        return decodedData.payload
        
        
    }
}
