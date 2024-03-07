//
//  ApiCall.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 04/03/2024.
//

import Foundation

class ApiCall{
    
    static let shared = ApiCall()
    private init(){}
    
    
    
    private let urlString = "https://kohls.p.rapidapi.com/products/list?"
    private let apiKey = "f38bda878bmsh5d97a1455c7ed88p1c55bajsn17e9b186f9a6"
    
    
    func fetchData(keyWord:String,offset:Int = 1)  async throws -> [ProductModel]?{
        
        let params = ["keyword":keyWord,"limit" : "24","offset":"\(offset)"]
        guard let url = URL(string: urlString) else{print("Invalid url"); return nil}

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
        
        guard let finalUrl = urlComponents?.url else{print("Invalid Final Url") ; return nil}
        
        var request = URLRequest(url: finalUrl)
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("kohls.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        
        let (data , response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{print("response error \(response)") ; return nil}
        
        guard let decodedData = try? JSONDecoder().decode(KeyWordSearchModel.self, from: data)
        else{print("Decoding failed") ; return nil}
        
        return decodedData.payload.products
    }
}
