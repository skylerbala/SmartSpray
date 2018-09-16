//
//  CropActions.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/14/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit

extension CropViewController {
    @objc func changeAngleSliderValue(_ sender: UISlider) {
        let radians: CGFloat = CGFloat(sender.value)
        self.changedAngle(value: radians)
    }
    
    
    @objc func cropButtonTouch(_ sender: UIButton) {
        self.cropAction()
    }
    
    @objc func resetViewButtonTouch(_ sender: UIButton) {
        self.resetView()
    }

}
