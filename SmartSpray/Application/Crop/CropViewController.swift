//
//  CropViewController.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/9/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import IGRPhotoTweaks
import EZLoadingActivity

class CropViewController: IGRPhotoTweakViewController {
    
    let resetViewButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(resetViewButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        button.backgroundColor = UIColor.gray
        button.setTitle("Reset Crop", for: UIControlState.normal)
        button.titleLabel?.textColor = UIColor.black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    let cropButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cropButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        button.backgroundColor = UIColor.gray
        button.setTitle("Process", for: UIControlState.normal)
        button.titleLabel?.textColor = UIColor.black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }

    @IBAction func onChandeAngleSliderValue(_ sender: UISlider) {
        let radians: CGFloat = CGFloat(sender.value)
        self.changedAngle(value: radians)
    }
    
    override open func setupThemes() {
        IGRPhotoTweakView.appearance().backgroundColor = UIColor.green

    }
    
    override open func customBorderColor() -> UIColor {
        return UIColor.red
    }
    
    
    @objc func cropButtonTouch(_ sender: UIButton) {
        self.cropAction()
    }

    @objc func resetViewButtonTouch(_ sender: UIButton) {
        self.resetView()
    }
}
