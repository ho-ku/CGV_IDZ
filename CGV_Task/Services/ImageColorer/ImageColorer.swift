//
//  ImageColorer.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit

protocol ImageColorer: class {
    func binarize(pixelArray: [Color], size: CGSize) -> UIImage?
    func grayGradation(pixelArray: [Color], size: CGSize) -> UIImage?
    func kirshMethodEdgeRecognition(pixelArray: [Color], size: CGSize) -> UIImage?
    func negativ(pixelArray: [Color], size: CGSize) -> UIImage?
}
