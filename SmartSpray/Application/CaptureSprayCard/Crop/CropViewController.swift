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
    
    let controlPanelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.SmartSpray.green
        return view
    }()
    
    let resetViewButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(resetViewButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        button.backgroundColor = UIColor.SmartSpray.blue
        button.setTitle("Reset Crop", for: UIControlState.normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    let cropButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cropButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        button.backgroundColor = UIColor.SmartSpray.blue
        button.setTitle("Process", for: UIControlState.normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    let angleSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = -Float(IGRRadianAngle.toRadians(45))
        slider.maximumValue = Float(IGRRadianAngle.toRadians(45))
        slider.value = 0.0
        return slider
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        angleSlider.addTarget(self, action: #selector(changeAngleSliderValue(_:)), for: UIControlEvents.valueChanged)
        tabBarController?.displayTabBar(isHidden: true)
    }
    
    override open func setupThemes() {
        IGRPhotoTweakView.appearance().backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        IGRCropLine.appearance().backgroundColor = UIColor.black
        IGRCropGridLine.appearance().backgroundColor = UIColor.black
        IGRCropCornerView.appearance().backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.35)
        IGRCropCornerLine.appearance().backgroundColor = UIColor.black
        IGRPhotoContentView.appearance().backgroundColor = UIColor.gray
        IGRCropMaskView.appearance().backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    override open func customBorderColor() -> UIColor {
        return UIColor.black
    }
    
    override func customBorderWidth() -> CGFloat {
        return 3.0
    }
}
