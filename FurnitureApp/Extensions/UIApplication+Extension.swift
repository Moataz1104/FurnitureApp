//
//  UIApplication+Extension.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 28/02/2024.
//

import Foundation
import UIKit
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
