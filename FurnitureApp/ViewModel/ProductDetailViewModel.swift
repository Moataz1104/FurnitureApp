//
//  ProductDetailViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 09/03/2024.
//

import Foundation


class ProductDetailViewModel:ObservableObject {
    @Published var productDetails : Product?
    @Published var isLoading : Bool = false
    @Published var shortDesc:String?
    @Published var longDesc:String?
    
    
    
    
    func fetchProductDetails(id:String){
        DispatchQueue.main.async {[weak self] in
            self?.isLoading = true
        }
        Task{
            if let fetchedDetails = try await ApiDetails.shared.fetchDetails(id: id){
                DispatchQueue.main.async {[weak self] in
                    self?.productDetails = fetchedDetails
                    self?.getShortText(fetched: fetchedDetails)
                    self?.getLongText(fetched: fetchedDetails)
                    self?.isLoading = false

                }
            }

        }
    }
    private func getShortText(fetched : Product){
        DispatchQueue.main.async{[weak self] in
            guard let shortDescription = fetched.description?.shortDescription else { return}
            guard let data = shortDescription.data(using: .utf8) else { return }
            guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return }
            self?.shortDesc = attributedString.string
        }
    }
    
    private func getLongText(fetched : Product){
        DispatchQueue.main.async{[weak self] in
            guard let longDescription = fetched.description?.longDescription else { return}
            guard let data = longDescription.data(using: .utf8) else { return }
            guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return }
            self?.longDesc = attributedString.string
        }
    }

}
