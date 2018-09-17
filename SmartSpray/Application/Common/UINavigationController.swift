//
//  UINavigationController.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/16/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setSmartSprayNavigationBar() {
        let loginButton = UIButton(type: .custom)
        loginButton.setImage(UIImage.init(named: "login-50"), for: .normal)
        
        let loginBarItem = UIBarButtonItem(customView: loginButton)
        loginBarItem.customView?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        loginBarItem.customView?.heightAnchor.constraint(equalToConstant: 35).isActive =  true
        
        self.navigationItem.leftBarButtonItem = loginBarItem
        
        self.navigationBar.barTintColor = UIColor.SmartSpray.yellow
    }
}

