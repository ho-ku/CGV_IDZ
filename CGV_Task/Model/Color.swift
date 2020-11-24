//
//  Color.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit

struct Color {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    
    var brightness: Double {
        return 0.3*Double(red) + 0.59*Double(green) + 0.11*Double(blue)
    }
    
    var elementList: [Int] {
        return [red, green, blue, alpha].map { Int($0) }
    }
}
