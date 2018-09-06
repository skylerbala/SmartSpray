//
//  DominantImageColors.swift
//  ImageColorQuantization
//
//  Created by Skyler Bala on 9/5/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

public class Color {
    var r: UInt8
    var g: UInt8
    var b: UInt8
    
    init(r: UInt8, g: UInt8, b: UInt8) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    var percentCoverage: Double?
    
    func colorDiff(otherColor: Color) -> Double {
        let r = pow(Double(self.r) - Double(otherColor.r), 2)
        let g = pow(Double(self.g) - Double(otherColor.g), 2)
        let b = pow(Double(self.b) - Double(otherColor.b), 2)
        let result = sqrt(r + g + b)
        return result
    }
}

public class ColorInt {
    var r: Int
    var g: Int
    var b: Int
    
    init(r: Int, g: Int, b: Int) {
        self.r = r
        self.g = g
        self.b = b
    }
}

enum ColorRange: String {
    case r = "r"
    case g = "g"
    case b = "b"
}


enum UIImageQuality: CGFloat {
    case lowest = 0.01
    case low = 0.1
    case medium = 0.25
    case high = 0.5
    case highest = 1.0
}

extension UIImage {
    func getDominantColors(numberOfColors: Int = 2, quality: UIImageQuality = .high) -> [Color] {
        let imageSize = CGSize(width: self.size.width * quality.rawValue , height: self.size.height * quality.rawValue)
        let resizedImage = resize(newSize: imageSize)
        
        var colors = resizedImage.getColors()
        var dominantColors = [Color]()
        
        quantizeImageColors(dominantColors: &dominantColors, colors: &colors, depth: 0, maxDepth: numberOfColors - 1)
        
        return dominantColors
    }
    
    func resize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("Error: Could not get resized image")
        }
        return newImage
    }
    
    private func getColors() -> [Color] {
        var colors = [Color]()
        
        let proivder = self.cgImage?.dataProvider
        let providerData = proivder?.data
        let dataPtr = CFDataGetBytePtr(providerData)!
        
        let numberOfComponents = 4 // r, g, b, a
        
        for pixelX in 0...Int(self.size.width) {
            for pixelY in 0...Int(self.size.height) {
                let pixelXY = ((Int(self.size.width) * pixelY) + pixelX) * numberOfComponents
                let newColor = Color(r: dataPtr[pixelXY], g: dataPtr[pixelXY + 1], b: dataPtr[pixelXY + 2])
                colors.append(newColor)
            }
        }
        return colors
    }
    
    private func quantizeImageColors(dominantColors: inout [Color], colors: inout [Color], depth: Int = 0, maxDepth: Int) {
        if depth == maxDepth {
            var newColor = ColorInt(r: 0, g: 0, b: 0)
            
            colors.forEach({ (color) in
                newColor.r += Int(color.r)
                newColor.g += Int(color.g)
                newColor.b += Int(color.b)
            })
            
            newColor.r = Int(round(Double(Int(newColor.r) / colors.count)))
            newColor.g = Int(round(Double(Int(newColor.g) / colors.count)))
            newColor.b = Int(round(Double(Int(newColor.b) / colors.count)))
            
            let newColorUInt8 = Color(r: UInt8(newColor.r), g: UInt8(newColor.g), b: UInt8(newColor.b))
            dominantColors.append(newColorUInt8)
            return
        }
        
        let componentToSortBy = colors.findBiggestRange()
        if componentToSortBy == .r {
            colors.sort(by: {$0.r < $1.r})
        }
        else if componentToSortBy == .g {
            colors.sort(by: {$0.g < $1.g})
        }
        else {
            colors.sort(by: {$0.b < $1.b})
        }
        
        let mid = colors.count / 2
        var bucket1 = Array(colors[0..<mid])
        var bucket2 = Array(colors[mid..<colors.count])
        
        quantizeImageColors(dominantColors: &dominantColors, colors: &bucket1, depth: depth + 1, maxDepth: maxDepth)
        quantizeImageColors(dominantColors: &dominantColors, colors: &bucket2, depth: depth + 1, maxDepth: maxDepth)
    }
}

extension Array where Element: Color {
    func findBiggestRange() -> ColorRange {
        var rMin: UInt8 = 255
        var rMax: UInt8 = 0
        
        var gMin: UInt8 = 255
        var gMax: UInt8 = 0
        
        var bMin: UInt8 = 255
        var bMax: UInt8 = 0
        
        self.forEach { (color) in
            rMin = Swift.min(rMin, color.r)
            rMax = Swift.max(rMax, color.r)
            gMin = Swift.min(gMin, color.g)
            gMax = Swift.max(gMax, color.g)
            bMin = Swift.min(bMin, color.b)
            bMax = Swift.max(bMax, color.b)
        }
        
        let rRange = findRGBRange(RGBValMax: rMax, RGBValMin: rMin)
        let gRange = findRGBRange(RGBValMax: gMax, RGBValMin: gMin)
        let bRange = findRGBRange(RGBValMax: bMax, RGBValMin: bMin)
        
        let biggestRange = Swift.max(rRange, gRange, bRange)
        
        if biggestRange == rRange { return .r }
        else if biggestRange == rRange { return .g }
        else { return .b }
        
    }
    
    private func findRGBRange(RGBValMax: UInt8, RGBValMin: UInt8) -> UInt8 {
        let range = RGBValMax - RGBValMin
        return range
    }
}
