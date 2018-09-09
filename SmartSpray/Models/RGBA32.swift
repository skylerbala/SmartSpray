//
//  RGBA32.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/9/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

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
