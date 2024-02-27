//
//  Color+extension.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 23/02/2024.
//

import Foundation
import SwiftUI

extension Color{
    init(hex:Int){
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
