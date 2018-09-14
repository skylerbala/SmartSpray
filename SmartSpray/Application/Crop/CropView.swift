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
        
        view.addSubview(resetViewButton)
        view.addSubview(cropButton)
        
        resetViewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetViewButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            resetViewButton.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            resetViewButton.heightAnchor.constraint(equalToConstant: 75),
            resetViewButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
        ])
        
        cropButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cropButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            cropButton.leftAnchor.constraint(equalTo: resetViewButton.rightAnchor),
            cropButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            cropButton.heightAnchor.constraint(equalTo: resetViewButton.heightAnchor),
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
