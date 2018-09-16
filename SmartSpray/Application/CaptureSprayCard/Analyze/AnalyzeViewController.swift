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
import IGRPhotoTweaks

class AnalyzeViewController: UIViewController {
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.black
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
        view.layer.shouldRasterize = true
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.SmartSpray.green
        return view
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(doneButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        button.setTitle("Done", for: UIControlState.normal)
        button.backgroundColor = UIColor.SmartSpray.blue
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(saveButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        button.setTitle("Save & Done", for: UIControlState.normal)
        button.backgroundColor = UIColor.SmartSpray.blue
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
        EZLoadingActivity.show("Processing Image...", disableUI: true)
        setViews()
        navigationController?.navigationBar.barTintColor = UIColor.SmartSpray.yellow
        tabBarController?.displayTabBar(isHidden: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isMovingToParentViewController {
            guard let image = imageView.image else { return }
            
            let yellow = Color(r: 255, g: 255, b: 0)
            let blue = Color(r: 0, g: 0, b: 255)
            let black = Color(r: 255, g: 255, b: 255)
            let white = Color(r: 0, g: 0, b: 0)
            
            
            let colors = [yellow, blue]
            
            image.quantizeImage(colors: colors, quality: .lower) { (quantizedImage) in
                EZLoadingActivity.hide(true, animated: true)
                
                self.imageView.image = quantizedImage as! UIImage
                
                
                
                quantizedImage.colorPalette.forEach({ (color) in
                    if color.colorDiff(otherColor: blue) < color.colorDiff(otherColor: yellow) {
                        let percentCoverage = (color.percentCoverage! * 100).rounded() / 100
                        self.showPercentageLabel(percent: percentCoverage)
                    }
                })
            }
        }
        
    }
    
    func showPercentageLabel(percent: Double) {
        percentCoverageLabel.text = "Percent Coverage: \(percent)%"
    }
}
