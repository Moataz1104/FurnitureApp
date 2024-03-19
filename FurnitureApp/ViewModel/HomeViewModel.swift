//
//  HomeViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 04/03/2024.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    @Published var products = [ProductModel]()
    @Published var totalResults = ""
    @Published var fetchByKeyWord = "chairs"
    @Published var isUsingSearch = false
    @Published var isLoading = false
    @Published var sortingId = "6"
    
    
    var offset = 0
    
    init(){
        loadData()
    }
    
    
    func loadData()  {
        Task {
            DispatchQueue.main.async {[weak self] in
                self?.isLoading = true
            }

            if let fetchedProducts = try! await ApiCall.shared.fetchData(keyWord: fetchByKeyWord) {
                DispatchQueue.main.async {[weak self] in
                    self?.products = fetchedProducts.payload.products ?? []
                    self?.totalResults = "\(fetchedProducts.count)"
                    self?.isLoading = false

                }
            }
        }
    }
    
    
    func fetchBySearch(){
        Task {
            if let fetchedProducts = try! await ApiCall.shared.fetchData(keyWord: fetchByKeyWord) {
                DispatchQueue.main.async {[weak self] in
                    self?.products = fetchedProducts.payload.products ?? []
                }
            }
        }
    }
    
    
    func fetchMoreData(){
        offset += 1
        Task {
            DispatchQueue.main.async {[weak self] in
                self?.isLoading = true
            }

            if let fetchedProducts = try! await ApiCall.shared.fetchData(keyWord: fetchByKeyWord) {
                DispatchQueue.main.async {[weak self] in
                    self?.products.append(contentsOf: fetchedProducts.payload.products ?? [])
                    self?.isLoading = false

                }
            }
        }
    }
    
}
