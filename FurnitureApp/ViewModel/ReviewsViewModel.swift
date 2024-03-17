//
//  ReviewsViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 13/03/2024.
//

import Foundation

class ReviewsViewModel : ObservableObject {
    
    @Published var reviews = [ReviewResult]()
    @Published var totalReviews = ""
    @Published var isLoading = false
    var offset = 0

    
    func fetchReviewsData(id:String){
        Task{
            DispatchQueue.main.async {[weak self] in
                self?.isLoading = true
            }
            if let results = try await ApiReviews.shared.fetchReviews(id: id){
                DispatchQueue.main.async {[weak self] in
                    self?.reviews = results.results!
                    self?.totalReviews = "\(results.totalResults!)"
                    self?.isLoading = false
                }
            }
        }
    }
    func fetchMoreReviewsData(id:String){
        offset += 1
        Task{
            DispatchQueue.main.async {[weak self] in
                self?.isLoading = true
            }
            if let results = try await ApiReviews.shared.fetchReviews(id: id,offset: "\(offset)"){
                DispatchQueue.main.async {[weak self] in
                    self?.reviews.append(contentsOf: results.results!)
                    self?.isLoading = false
                }
            }
        }
    }

    
}
