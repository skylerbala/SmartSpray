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
        button.addTarget(self, action: #selector(saveButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        button.setTitle("Save", for: UIControlState.normal)
        return button
    }()
    
    let percentCoverageLabel: UILabel = {
        let label = UILabel()
        label.text = "Percent Coverage: Processing"
        return label
    }()
    
    let doneBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(doneBarButtonTouch))
        return barButton
    }()
    
    var rgbValues: [Dictionary<String, Int>]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EZLoadingActivity.show("Processing Image...", disableUI: true)
        setViews()

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
            
            doneBarButton.target = self
            navigationItem.rightBarButtonItem = doneBarButton
        }
        
    }
    
    @objc func doneBarButtonTouch() {
        navigationController?.popToViewController((navigationController?.viewControllers[0])!, animated: true)
    }
    
    @objc func saveButtonTouch(_ sender: UIButton) {
        let saveFormVC = SaveFormViewController()
        if !(navigationController?.topViewController is SaveFormViewController) {
            navigationController?.pushViewController(saveFormVC, animated: true)
        }
    }
    
    func showPercentageLabel(percent: Double) {
        percentCoverageLabel.text = "Percent Coverage: \(percent)%"
    }
}

