//
//  ViewController.swift
//  SnapCard
//
//  Created by Skyler Bala on 9/3/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {

    var imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "image")
       return image
    }()
    
    var rgbValues: [Dictionary<String, Int>]!
    
    var colors: [Dictionary<String, Int>] = [Dictionary<String, Int>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let image = imageView.image
        let imageSize = image?.size
        let pixelWidth = Int((imageSize?.width)!)
        let pixelHeight = Int((imageSize?.height)!)
        
        rgbValues = image?.getRGBValues()
        quantize(rgbValues: rgbValues, depth: 0, maxDepth: 1)
        print("gang")
        
        let oldImage = imageView.image
        
        imageView.image = processPixelsInImage(oldImage!)
        
    }
    
    
    
    func findBiggestRange(rgbValues: [Dictionary<String, Int>]) -> String {
        //hardcoded values
        var rMin = Int(999)
        var rMax = Int(-999)
        
        var gMin = Int(999)
        var gMax = Int(-999)
        
        var bMin = Int(999)
        var bMax = Int(-999)
        
        rgbValues.forEach { (pixel) in
            rMin = min(rMin, pixel["r"]!)
            rMax = max(rMax, pixel["r"]!)
            gMin = min(gMin, pixel["g"]!)
            gMax = max(gMax, pixel["g"]!)
            bMin = min(bMin, pixel["b"]!)
            bMax = max(bMax, pixel["b"]!)
        }
        
        let rRange = rMax - rMin
        let gRange = gMax - gMin
        let bRange = bMax - bMin
        
        let biggestRange = max(rRange, gRange, bRange)
        
        if biggestRange == rRange {
            return "r"
        }
        else if biggestRange == bRange {
            return "g"
        }
        else {
            return "b"
        }
        
    }
    
    func quantize(rgbValues: [Dictionary<String, Int>], depth: Int = 0, maxDepth: Int = 1) -> [Dictionary<String, Int>]? {
        
        if depth == maxDepth {
            var color: Dictionary<String, Int> = [
                "r": 0,
                "g": 0,
                "b": 0
            ]
            
            rgbValues.forEach({ (val) in
                color["r"]! += val["r"]!
                color["g"]! += val["g"]!
                color["b"]! += val["b"]!
            })
            
            color["r"] = Int(round(Double(color["r"]! / rgbValues.count)))
            color["g"] = Int(round(Double(color["g"]! / rgbValues.count)))
            color["b"] = Int(round(Double(color["b"]! / rgbValues.count)))
            self.colors.append(color)
            return nil
        }
        
        let componentToSortBy = findBiggestRange(rgbValues: rgbValues)
        let sortedVals = rgbValues.sorted { (p1, p2) -> Bool in
            if p1[componentToSortBy]! < p2[componentToSortBy]! {
                return true
            }
            else {
                return false
            }
        }
        
        let mid = sortedVals.count / 2
        let bucket1 = Array(sortedVals[0..<mid])
        let bucket2 = Array(sortedVals[mid..<sortedVals.count])
        
        quantize(rgbValues: bucket1, depth: depth + 1, maxDepth: maxDepth)
        quantize(rgbValues: bucket2, depth: depth + 1, maxDepth: maxDepth)
        
        return nil
    }
    
    
    func processPixelsInImage(_ image: UIImage) -> UIImage? {
        guard let inputCGImage = image.cgImage else {
            //print("unable to get cgImage")
            return nil
        }
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
        
        let quantizedColors = self.colors
        
        let pixelBuffer = buffer.bindMemory(to: RGBA32.self, capacity: width * height)
        
        var percent1 = 0.0
        var percent2 = 0.0
        
        for row in 0 ..< Int(height) {
            for column in 0 ..< Int(width) {
                let offset = row * width + column
                let currPixelColor = [
                    "r": Int(pixelBuffer[offset].redComponent),
                    "g": Int(pixelBuffer[offset + 1].greenComponent),
                    "b": Int(pixelBuffer[offset + 2].blueComponent),
                ]


                let color1 = self.colors[0]
                let color2 = self.colors[1]

                let c1Diff = colorDiff(c1: self.colors[0], c2: currPixelColor)
                let c2Diff = colorDiff(c1: self.colors[1], c2: currPixelColor)

                
                if c1Diff < c2Diff {
                    percent1 += 1
                    pixelBuffer[offset] = RGBA32(red: UInt8(color1["r"]!), green: UInt8(color1["g"]!), blue: UInt8(color1["b"]!), alpha: 255)
                }
                else {
                    percent2 += 1
                    pixelBuffer[offset] = RGBA32(red: UInt8(color2["r"]!), green: UInt8(color2["g"]!), blue: UInt8(color2["b"]!), alpha: 255)

                }
            }
        }
        percent1 = percent1 / Double(height * width) * 100
        percent2 = percent2 / Double(height * width) * 100
        
        let outputCGImage = context.makeImage()!
        let outputImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
        
        return outputImage
        
    }
    
    
    func colorDiff(c1: Dictionary<String, Int>, c2: Dictionary<String, Int>) -> Double {
        let r = (c1["r"]! - c2["r"]!) * (c1["r"]! - c2["r"]!)
        let g = (c1["g"]! - c2["g"]!) * (c1["g"]! - c2["g"]!)
        let b = (c1["b"]! - c2["b"]!) * (c1["b"]! - c2["b"]!)
        return sqrt(Double(r + g + b))
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
}

extension UIImage {
    func pixelData() -> [UInt8]? {
        let size = self.size
        let dataSize = size.width * size.height * 4 // 4 bytes an int
        var pixelData = [UInt8](repeatElement(0, count: Int(dataSize)))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext.init(data: &pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 4 * Int(size.width), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let cgImage = self.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        return pixelData
    }
    
    subscript (x: Int, y: Int) -> UIColor? {
        
        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return nil
        }
        
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * y) + x) * numberOfComponents
        
        let r = CGFloat(data![pixelData]) / 255.0
        let g = CGFloat(data![pixelData + 1]) / 255.0
        let b = CGFloat(data![pixelData + 2]) / 255.0
        let a = CGFloat(data![pixelData + 3]) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    
    func getRGBValues() -> [Dictionary<String, Int>] {
        var rgbValues: [Dictionary<String, Int>] = [Dictionary<String, Int>]()
        
        let provider = self.cgImage?.dataProvider
        let providerData = provider?.data
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfComponents = 4
        
        for pixelW in 1...Int(self.size.width) {
            for pixelH in 1...Int(self.size.height) {
                let pixelData = ((Int(size.width) * pixelH) + pixelW) * numberOfComponents
                rgbValues.append([
                    "r": Int(data![pixelData]),
                    "g": Int(data![pixelData + 1]),
                    "b": Int(data![pixelData + 2]),
                    ]
                )
            }
        }
        return rgbValues
    }
    
    


}

