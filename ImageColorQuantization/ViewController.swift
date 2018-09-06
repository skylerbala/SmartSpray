//
//  ViewController.swift
//  ImageColorQuantization
//
//  Created by Skyler Bala on 9/3/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {

    var imageView: UIImageView = {
        let view = UIImageView()
        //view.image = #imageLiteral(resourceName: "image-1")
       return view
    }()
    
    var rgbValues: [Dictionary<String, Int>]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        guard let image = imageView.image else { return }
        
        let yellow = Color(r: 255, g: 255, b: 0)
        let blue = Color(r: 0, g: 0, b: 255)
        
        let colors = [yellow, blue]
        
        let quantizedImage = image.quantizeImage(colors: colors, numberOfColors: nil, quality: nil)
        
        imageView.image = quantizedImage as! UIImage

        quantizedImage?.colorPalette.forEach({ (color) in
            if color.colorDiff(otherColor: yellow) < color.colorDiff(otherColor: blue) {
                print(color.percentCoverage)
                print("Color is Yellow: \(color.r, color.g, color.b)")
            }
            else {
                print(color.percentCoverage)
                print("Color is Blue: \(color.r, color.g, color.b)")
            }
        })
    }
}

