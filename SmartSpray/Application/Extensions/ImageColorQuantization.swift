//
//  ImageColorQuantization.swift
//  ImageColorQuantization
//
//  Created by Skyler Bala on 9/5/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func quantizeImage(colors: [Color]? = nil, numberOfColors: Int? = 2, quality: UIImageQuality? = .lower, completion: @escaping ((QuantizedImage) -> Void)) {
        var quantizedColors: [Color]
        var resizedImage: UIImage
        if colors != nil {
            quantizedColors = colors!
            resizedImage = resize(quality: quality!)
        }
        else {
            (quantizedColors, resizedImage) = self.getDominantColors(numberOfColors: numberOfColors!, quality: quality!)
        }
        
        guard let inputCGImage = self.cgImage else { return }

        let colorSpace       = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel    = 4
        let width            = Int(resizedImage.size.width)
        let height           = Int(resizedImage.size.height)
        let bitsPerComponent = 8
        let bytesPerRow      = bytesPerPixel * width
        let bitmapInfo       = RGBA32.bitmapInfo
        
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
            //print("unable to create context")
            return
        }
        context.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        guard let buffer = context.data else {
            //print("unable to get context data")
            return
        }
        
        let dataPtr = buffer.bindMemory(to: RGBA32.self, capacity: width * height)
        
        var color1Percent: Double = 0.0
        var color2Percent: Double = 0.0
        
        for pixelX in 0 ..< Int(height) {
            for pixelY in 0 ..< Int(width) {
                let pixelXY = pixelX * width + pixelY
                let currPixelColor = Color(r: dataPtr[pixelXY].redComponent, g: dataPtr[pixelXY + 1].redComponent, b: dataPtr[pixelXY + 2].redComponent)
                
                let color1 = quantizedColors[0]
                let color2 = quantizedColors[1]
                
                let c1Diff = color1.colorDiff(otherColor: currPixelColor)
                let c2Diff = color2.colorDiff(otherColor: currPixelColor)
                
                
                if c1Diff < c2Diff {
                    color1Percent += 1
                    dataPtr[pixelXY] = RGBA32(red: color1.r, green: color1.g, blue: color1.b, alpha: 255)
                }
                else {
                    color2Percent += 1
                    dataPtr[pixelXY] = RGBA32(red: color2.r, green: color2.g, blue: color2.b, alpha: 255)
                }
            }
        }
        
        quantizedColors[0].percentCoverage = color1Percent / Double(height * width) * 100
        quantizedColors[1].percentCoverage = color2Percent / Double(height * width) * 100
        
        let outputCGImage = context.makeImage()!
        
        let quantizedImage = QuantizedImage(colorPalette: quantizedColors, cgImage: outputCGImage, scale: self.scale, orientation: self.imageOrientation)
        
        completion(quantizedImage)
    }
}
