//
//  User.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit

final class User {
    
    // MARK: - Properties
    var pixelUInt8Array: [UInt8]? {
        didSet {
            guard let arr = pixelUInt8Array else { return }
            var colorsArr: [Color] = []
            for (index, pixel) in arr.enumerated() {
                if index % 4 == 0 {
                    let newColor = Color(red: Double(pixel), green: Double(arr[index+1]), blue: Double(arr[index+2]), alpha: Double(arr[index+3]))
                    colorsArr.append(newColor)
                } else {
                    continue
                }
            }
            pixelColorArray = colorsArr
        }
    }
    var pixelColorArray: [Color]?
    
    static let shared = User()
    private init () { }
    
}
