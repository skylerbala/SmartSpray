//
//  PredictionsListView.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/14/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

extension PredictionsListViewController {
    func setNavigationBar() {
       
        let navController = UIApplication.shared.keyWindow!.rootViewController as! UINavigationController
        
        let loginButton = UIButton(type: .custom)
        loginButton.setImage(UIImage.init(named: "login-50"), for: .highlighted)
        
        let loginBarItem = UIBarButtonItem(customView: loginButton)
        loginBarItem.customView?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        loginBarItem.customView?.heightAnchor.constraint(equalToConstant: 35).isActive =  true
        
        navController.navigationBar.barTintColor = UIColor.blue
        
    }
}
