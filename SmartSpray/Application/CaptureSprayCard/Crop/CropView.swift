//
//  CropView.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/9/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

extension CropViewController {
    func setViews() {
        let layoutGuide = view.safeAreaLayoutGuide
        view.addSubview(controlPanelView)
        controlPanelView.addSubview(resetViewButton)
        controlPanelView.addSubview(cropButton)
        controlPanelView.addSubview(angleSlider)
        
        controlPanelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controlPanelView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            controlPanelView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor),
            controlPanelView.heightAnchor.constraint(equalToConstant: 130),
            controlPanelView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
        
        resetViewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetViewButton.bottomAnchor.constraint(equalTo: controlPanelView.bottomAnchor, constant: -8),
            resetViewButton.leftAnchor.constraint(equalTo: controlPanelView.leftAnchor, constant: 8),
            resetViewButton.heightAnchor.constraint(equalTo: controlPanelView.heightAnchor, multiplier: 0.45),
            resetViewButton.widthAnchor.constraint(equalTo: controlPanelView.widthAnchor, multiplier: 0.5, constant: -4),
        ])

        cropButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cropButton.bottomAnchor.constraint(equalTo: resetViewButton.bottomAnchor),
            cropButton.leftAnchor.constraint(equalTo: resetViewButton.rightAnchor, constant: 4),
            cropButton.rightAnchor.constraint(equalTo: controlPanelView.rightAnchor, constant: -8),
            cropButton.heightAnchor.constraint(equalTo: resetViewButton.heightAnchor),
        ])

        angleSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            angleSlider.leftAnchor.constraint(equalTo: controlPanelView.leftAnchor, constant: 8),
            angleSlider.rightAnchor.constraint(equalTo: controlPanelView.rightAnchor, constant: -8),
            angleSlider.heightAnchor.constraint(equalTo: resetViewButton.heightAnchor),
            angleSlider.topAnchor.constraint(equalTo: controlPanelView.topAnchor, constant: 8)
        ])
       
    }
    
    func setNavigationBar() {

    }
    

}
