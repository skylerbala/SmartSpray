//
//  PredictView.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/12/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

extension PredictCoverageViewController {
    func setViews() {
        let layoutGuide = view.safeAreaLayoutGuide
        
        //view.addSubview(predictButton)
        
//        predictButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            predictButton.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 8),
//            predictButton.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -8),
//            predictButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -50),
//            predictButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
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

//button has logo on it

