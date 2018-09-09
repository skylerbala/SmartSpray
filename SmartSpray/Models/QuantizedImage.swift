//
//  QuantizedImage.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/9/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

public class QuantizedImage: UIImage {
    var colorPalette: [Color] = []
    
    init(colorPalette: [Color], cgImage: CGImage, scale: CGFloat, orientation: UIImageOrientation) {
        super.init(cgImage: cgImage, scale: scale, orientation: orientation)
        self.colorPalette = colorPalette
    }
    
    
    required convenience public init(imageLiteralResourceName name: String) {
        fatalError("init(imageLiteralResourceName:) has not been implemented")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
