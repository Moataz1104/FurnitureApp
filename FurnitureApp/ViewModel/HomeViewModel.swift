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
    @Published var fetchByKeyWord = "chair"
    @Published var isUsingSearch = false
    @Published var isLoading = false
    
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
                    self?.products = fetchedProducts
                    self?.isLoading = false

                }
            }
        }
    }
    
    
    func fetchBySearch(){
        Task {
            if let fetchedProducts = try! await ApiCall.shared.fetchData(keyWord: fetchByKeyWord) {
                DispatchQueue.main.async {[weak self] in
                    self?.products = fetchedProducts
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

            if let fetchedProducts = try! await ApiCall.shared.fetchData(keyWord: fetchByKeyWord,offset: offset) {
                DispatchQueue.main.async {[weak self] in
                    self?.products.append(contentsOf: fetchedProducts)
                    self?.isLoading = false

                }
            }
        }
    }
    
}
