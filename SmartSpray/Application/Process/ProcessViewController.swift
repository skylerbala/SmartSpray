//
//  ViewController.swift
//  ImageColorQuantization
//
//  Created by Skyler Bala on 9/3/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import CoreGraphics
import EZLoadingActivity

class ProcessViewController: UIViewController {
    
    var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: UIControlState.normal)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    let percentCoverageLabel: UILabel = {
        let label = UILabel()
        label.text = "Percent Coverage: Processing"
        return label
    }()
    
    var rgbValues: [Dictionary<String, Int>]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        EZLoadingActivity.show("Processing Image...", disableUI: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let image = imageView.image else { return }
        
        let yellow = Color(r: 255, g: 255, b: 0)
        let blue = Color(r: 0, g: 0, b: 255)
        let black = Color(r: 255, g: 255, b: 255)
        let white = Color(r: 0, g: 0, b: 0)

        
        let colors = [yellow, blue]

        image.quantizeImage { (quantizedImage) in
            EZLoadingActivity.hide(true, animated: true)
            
            self.imageView.image = quantizedImage as! UIImage
            
            
            
            quantizedImage.colorPalette.forEach({ (color) in
                if color.colorDiff(otherColor: black) < color.colorDiff(otherColor: white) {
                    let percentCoverage = (color.percentCoverage! * 100).rounded() / 100
                    self.showPercentageLabel(percent: percentCoverage)
                }
            })
        }

        
        
    }
    
    func showPercentageLabel(percent: Double) {
        percentCoverageLabel.text = "Percent Coverage: \(percent)%"
    }
}

