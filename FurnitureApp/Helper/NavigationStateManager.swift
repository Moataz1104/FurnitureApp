//
//  NavigationStateManager.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 26/03/2024.
//

import Foundation

@MainActor
class NavigationStateManager<NavigationStage: Hashable>: ObservableObject {
    @Published var selectionPath: [NavigationStage]
    
    init(selectionPath: [NavigationStage] = []) {
        self.selectionPath = selectionPath
    }
    
    func pushToStage(stage: NavigationStage) {
        selectionPath.append(stage)
    }
    
    func popToRoot() {
        selectionPath = []
    }
    

}

enum AppNavigationPath: Hashable {
    case checkOut(String)
    case successView
}


