//
//  MainViewController.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/28/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var token: String!
    var firstLoad: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarVC()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstLoad {
            handleLogout()
            firstLoad = false
        }
    }
    
    func handleLogout() {
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func setTabBarVC() {
        
        let predictVC = PredictCoverageViewController()
        predictVC.title = "Predict"
        predictVC.tabBarItem = UITabBarItem(title: "Predict", image: #imageLiteral(resourceName: "icons8-calculator-50"), selectedImage: #imageLiteral(resourceName: "icons8-calculator-50"))
        
        
        let captureVC = ScannerViewController()
        captureVC.title = "Capture"
        captureVC.tabBarItem = UITabBarItem(title: "Capture", image: #imageLiteral(resourceName: "icons8-screenshot-50"), selectedImage: #imageLiteral(resourceName: "icons8-screenshot-50"))
        
        let predictionsListVC = PredictionsListViewController()
        predictionsListVC.title = "Predictions"
        predictionsListVC.tabBarItem = UITabBarItem(title: "Capture", image: #imageLiteral(resourceName: "icons8-menu-50"), selectedImage:#imageLiteral(resourceName: "icons8-menu-50"))
        
        let vcs = [predictVC, captureVC, predictionsListVC]
        
        self.viewControllers = vcs.map({ (vc) -> UIViewController in
            let navController = UINavigationController(rootViewController: vc)
            return navController
        })
        
    }
}
