//
//  HomeViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 04/03/2024.
//

import Foundation


class HomeViewModel : ObservableObject{
    @Published var products = [KeyWordSearchModel]()
    @Published var firstFetch :String = "chair"
    @Published var fetchByKeyWord = ""
    @Published var isUsingSearch = false
    
    init(){
        loadData()
    }
    
    func loadData() {
        Task {
            if let fetchedProducts = try! await ApiCall.shared.fetchData(keyWord: firstFetch) {
                DispatchQueue.main.async {[weak self] in
                    self?.products = fetchedProducts
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
    
}
