//
//  DependencyInjection.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import Foundation

final class DependencyInjection {
    
    static let shared = DependencyInjection()
    private init() { }
    
    func imageColorer() -> ImageColorer {
        return ImageColoringService()
    }
    
}
