//
//  FetchProductDetails.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 07/03/2024.
//

import Foundation

class ApiDetails{
    
    static let shared = ApiDetails()
    private init(){}
    
    private let urlString = "https://kohls.p.rapidapi.com/products/detail"
    private let apiKey = "0eba5408f5mshb9937614eee1533p143095jsna5a04c8b6496"

    
    
    func fetchDetails(id : String) async throws -> Product?{
        let params = ["webID" : id]
        guard let url = URL(string: urlString) else{print("Invalid details url"); return nil}
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = params.map{URLQueryItem(name: $0, value: $1)}

        guard let finalUrl = urlComponents?.url else{print("Invalid Final details Url") ; return nil}
        
        var request = URLRequest(url: finalUrl)
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("kohls.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        
        let (data , response) = try await URLSession.shared.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else{print("details response error \(response)") ; return nil}
        
        guard let decodedData = try? JSONDecoder().decode(ProductDetailModel.self, from: data)else{print("detail Decoding failed") ; return nil }
        

        return decodedData.payload.products?.first


    }
}
