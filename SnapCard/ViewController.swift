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
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "image")
       return view
    }()
    
    var rgbValues: [Dictionary<String, Int>]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        guard let image = imageView.image else { return }
        
        let quantizedImage = image.quantizeImage(colors: nil, quality: .lowest)
        
        imageView.image = quantizedImage as! UIImage
    }

}

