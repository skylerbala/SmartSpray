//
//  ImageColorQuantization.swift
//  SnapCard
//
//  Created by Skyler Bala on 9/5/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

public class QuantizedImage: UIImage {
    var colorPalette: [Color] = []
    
    init(colorPalette: [Color]) {
        super.init()
        self.colorPalette = colorPalette
    }
    
    required convenience public init(imageLiteralResourceName name: String) {
        fatalError("init(imageLiteralResourceName:) has not been implemented")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func quantizeImage(colors: [Color]? = nil, quality: UIImageQuality = .medium) -> QuantizedImage? {
        var quantizedColors: [Color]
        if colors != nil {
            quantizedColors = colors!
        }
        else {
            quantizedColors = self.getDominantColors(numberOfColors: 2, quality: quality)
        }

        
        guard let inputCGImage = self.cgImage else { return nil }

        let colorSpace       = CGColorSpaceCreateDeviceRGB()
        let width            = inputCGImage.width
        let height           = inputCGImage.height
        let bytesPerPixel    = 4
        let bitsPerComponent = 8
        let bytesPerRow      = bytesPerPixel * width
        let bitmapInfo       = RGBA32.bitmapInfo
        
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
            //print("unable to create context")
            return nil
        }
        context.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        guard let buffer = context.data else {
            //print("unable to get context data")
            return nil
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
        
        
        let quantizedImage = context.getIm
        
        
        return quantizedImage
    }
}



struct RGBA32: Equatable {
    private var color: UInt32
    
    var redComponent: UInt8 {
        return UInt8((color >> 24) & 255)
    }
    
    var greenComponent: UInt8 {
        return UInt8((color >> 16) & 255)
    }
    
    var blueComponent: UInt8 {
        return UInt8((color >> 8) & 255)
    }
    
    var alphaComponent: UInt8 {
        return UInt8((color >> 0) & 255)
    }
    
    init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        let red   = UInt32(red)
        let green = UInt32(green)
        let blue  = UInt32(blue)
        let alpha = UInt32(alpha)
        color = (red << 24) | (green << 16) | (blue << 8) | (alpha << 0)
    }
    
    static let red     = RGBA32(red: 255, green: 0,   blue: 0,   alpha: 255)
    static let green   = RGBA32(red: 0,   green: 255, blue: 0,   alpha: 255)
    static let blue    = RGBA32(red: 0,   green: 0,   blue: 255, alpha: 255)
    static let white   = RGBA32(red: 255, green: 255, blue: 255, alpha: 255)
    static let black   = RGBA32(red: 0,   green: 0,   blue: 0,   alpha: 255)
    static let magenta = RGBA32(red: 255, green: 0,   blue: 255, alpha: 255)
    static let yellow  = RGBA32(red: 255, green: 255, blue: 0,   alpha: 255)
    static let cyan    = RGBA32(red: 0,   green: 255, blue: 255, alpha: 255)
    
    static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
    
    static func ==(lhs: RGBA32, rhs: RGBA32) -> Bool {
        return lhs.color == rhs.color
    }
}

struct ColorLAB {
    var rLAB: Double
    var gLAB: Double
    var bLAB: Double
    
    init(r: Double, g: Double, b: Double) {
        let rVal = r / 255
        let gVal = g / 255
        let bVal = b / 255
        
        if (rVal / 255 > 0.04045) {
            self.rLAB = pow(((rVal + 0.055) / 1.055), 2.4)
        }
        else {
            self.rLAB = rVal / 12.92
        }
        
        if (gVal / 255 > 0.04045) {
            self.gLAB = pow(((gVal + 0.055) / 1.055), 2.4)
        }
        else {
            self.gLAB = gVal / 12.92
        }
        
        if (bVal / 255 > 0.04045) {
            self.bLAB = pow(((bVal + 0.055) / 1.055), 2.4)
        }
        else {
            self.bLAB = bVal / 12.92
        }
        
        self.rLAB *= 100
        self.gLAB *= 100
        self.bLAB *= 100
        
    }
    
}
