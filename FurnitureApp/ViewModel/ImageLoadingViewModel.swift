//
//  ImageLoadingViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 05/03/2024.
//

import Foundation
import Combine
import SwiftUI

class ImageLoadingViewModel:ObservableObject {
    
    @Published var image : UIImage? = nil
    @Published var isLoading = false
    
    var cancellables = Set<AnyCancellable>()
    let urlString : String
    
    init(urlString: String) {
        self.urlString = urlString
        downLoadImage()

    }
    
    func downLoadImage(){
        isLoading = true
        
        guard let url = URL(string: urlString) else{isLoading = false; return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: {[weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)

    }
    
}
