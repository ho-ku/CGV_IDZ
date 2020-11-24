//
//  ImageColoringService.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit

final class ImageColoringService: ImageColorer {
    
    private let pixelConverter = PixelConverter()
    
    func binarize(pixelArray: [Color], size: CGSize) -> UIImage? {
        var userPixels = pixelArray
        for (index, pixel) in userPixels.enumerated() {
            let brightness = pixel.brightness
            userPixels[index].red = Int(brightness) > C.binarizationLimit ? 255 : 0
            userPixels[index].green = Int(brightness) > C.binarizationLimit ? 255 : 0
            userPixels[index].blue = Int(brightness) > C.binarizationLimit ? 255 : 0
        }
        
        if let cgImage = pixelConverter.imageFrom(pixels: userPixels, width: Int(size.width), height: Int(size.height)) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    func grayGradation(pixelArray: [Color], size: CGSize) -> UIImage? {
        var userPixels = pixelArray
        for (index, pixel) in userPixels.enumerated() {
            let brightness = pixel.brightness
            userPixels[index].red = Double(brightness)
            userPixels[index].green = Double(brightness)
            userPixels[index].blue = Double(brightness)
        }
        
        if let cgImage = pixelConverter.imageFrom(pixels: userPixels, width: Int(size.width), height: Int(size.height)) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    func negativ(pixelArray: [Color], size: CGSize) -> UIImage? {
        var userPixels = pixelArray
        for (index, _) in userPixels.enumerated() {
            userPixels[index].red = 255 - userPixels[index].red
            userPixels[index].green = 255 - userPixels[index].green
            userPixels[index].blue = 255 - userPixels[index].blue
        }
        
        if let cgImage = pixelConverter.imageFrom(pixels: userPixels, width: Int(size.width), height: Int(size.height)) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    func kirshMethodEdgeRecognition(pixelArray: [Color], size: CGSize) -> UIImage? {
        var userPixels = pixelArray
        let height = Int(size.height)
        let width = Int(size.width)
        for x in 1...width-2 {
            for y in 1...height-2 {
                let rMatrix = [
                    pixelArray[(y-1)*width+x-1].red,
                    pixelArray[(y-1)*width+x].red,
                    pixelArray[(y-1)*width+x+1].red,
                    pixelArray[y*width+x+1].red,
                    pixelArray[(y+1)*width+x+1].red,
                    pixelArray[(y+1)*width+x].red,
                    pixelArray[(y+1)*width+x-1].red,
                    pixelArray[y*width+x-1].red
                ].map { Int($0) }
                let gMatrix = [
                    pixelArray[(y-1)*width+x-1].green,
                    pixelArray[(y-1)*width+x].green,
                    pixelArray[(y-1)*width+x+1].green,
                    pixelArray[y*width+x+1].green,
                    pixelArray[(y+1)*width+x+1].green,
                    pixelArray[(y+1)*width+x].green,
                    pixelArray[(y+1)*width+x-1].green,
                    pixelArray[y*width+x-1].green
                ].map { Int($0) }
                let bMatrix = [
                    pixelArray[(y-1)*width+x-1].blue,
                    pixelArray[(y-1)*width+x].blue,
                    pixelArray[(y-1)*width+x+1].blue,
                    pixelArray[y*width+x+1].blue,
                    pixelArray[(y+1)*width+x+1].blue,
                    pixelArray[(y+1)*width+x].blue,
                    pixelArray[(y+1)*width+x-1].blue,
                    pixelArray[y*width+x-1].blue
                ].map { Int($0) }
                var fRedMax = -10
                var fGreenMax = -10
                var fBlueMax = -10
                for i in 0...7 {
                    var s = rMatrix[i] + rMatrix[addMod8(i, 1)] + rMatrix[addMod8(i, 2)]
                    var t = rMatrix[addMod8(i, 3)] + rMatrix[addMod8(i, 4)] + rMatrix[addMod8(i, 5)] + rMatrix[addMod8(i, 6)] + rMatrix[addMod8(i, 7)]
                    if fRedMax < abs(5*s-3*t) {
                        fRedMax = abs(5*s-3*t)
                    }
                    s = gMatrix[i] + gMatrix[addMod8(i, 1)] + gMatrix[addMod8(i, 2)]
                    t = gMatrix[addMod8(i, 3)] + gMatrix[addMod8(i, 4)] + gMatrix[addMod8(i, 5)] + gMatrix[addMod8(i, 6)] + gMatrix[addMod8(i, 7)]
                    if fGreenMax < abs(5*s-3*t) {
                        fGreenMax = abs(5*s-3*t)
                    }
                    s = bMatrix[i] + bMatrix[addMod8(i, 1)] + bMatrix[addMod8(i, 2)]
                    t = bMatrix[addMod8(i, 3)] + bMatrix[addMod8(i, 4)] + bMatrix[addMod8(i, 5)] + bMatrix[addMod8(i, 6)] + bMatrix[addMod8(i, 7)]
                    if fBlueMax < abs(5*s-3*t) {
                        fBlueMax = abs(5*s-3*t)
                    }
                }
                fRedMax = fRedMax > 255 ? 255 : fRedMax
                fGreenMax = fGreenMax > 255 ? 255 : fGreenMax
                fBlueMax = fBlueMax > 255 ? 255 : fBlueMax
                userPixels[y*width+x].red = Double(fRedMax)
                userPixels[y*width+x].green = Double(fGreenMax)
                userPixels[y*width+x].blue = Double(fBlueMax)
            }
        }
        
        if let cgImage = pixelConverter.imageFrom(pixels: userPixels, width: Int(size.width), height: Int(size.height)) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    private func addMod8(_ lhs: Int, _ rhs: Int) -> Int {
        return rhs + lhs > 7 ? rhs + lhs - 8 : lhs + rhs
    }
    
}
