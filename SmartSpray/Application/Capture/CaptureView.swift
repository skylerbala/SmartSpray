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
    
    func setNavigationBar() {
        let loginButton = UIButton(type: .custom)
        loginButton.setImage(UIImage.init(named: "login-50"), for: .normal)
        
        let loginBarItem = UIBarButtonItem(customView: loginButton)
        loginBarItem.customView?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        loginBarItem.customView?.heightAnchor.constraint(equalToConstant: 35).isActive =  true
        
        navigationItem.leftBarButtonItem = loginBarItem
        
        navigationController?.navigationBar.barTintColor = UIColor.SmartSpray.yellow
    }
}
