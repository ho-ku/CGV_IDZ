//
//  PixelConverter.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit

final class PixelConverter {
    
    func imageFrom(pixels: [Color], width: Int, height: Int) -> CGImage? {
        var byteArray = pixels.flatMap { $0.elementList }.map { UInt8($0) }
        let bitmapCount: Int = byteArray.count
        let elmentLength: Int = 4
        let render: CGColorRenderingIntent = CGColorRenderingIntent.defaultIntent
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let providerRef: CGDataProvider = CGDataProvider(data: NSData(bytes: &byteArray, length: bitmapCount * elmentLength))!
        let cgimage: CGImage? = CGImage(width: width, height: height, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: width * elmentLength, space: rgbColorSpace, bitmapInfo: bitmapInfo, provider: providerRef, decode: nil, shouldInterpolate: true, intent: render)
        guard let cgImage = cgimage else { return nil }
        return cgImage
    }
    
}
