//
//  CaptureView.swift
//  ImageColorQuantization
//
//  Created by Skyler Bala on 9/8/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

extension CaptureViewController {
    func setViews() {
        let layoutGuide = view.safeAreaLayoutGuide
        
        //view.addSubview(UIView)
        view.addSubview(captureButton)
        //view.addSubview(cardImageView)
        
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            captureButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -50),
            captureButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
            captureButton.heightAnchor.constraint(equalToConstant: 75),
            captureButton.widthAnchor.constraint(equalToConstant: 75),
        ])
    }
    
}
