//
//  LoginViewController.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/27/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import Alamofire
import ILLoginKit

class LoginViewController: UIViewController {
    
    var hasShownLogin = false
    
    lazy var loginCoordinator: LoginCoordinatorMod = {
        return LoginCoordinatorMod(rootViewController: self)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard !hasShownLogin else {
            return
        }
        
        hasShownLogin = true
        loginCoordinator.start()
    }
}

// MARK: - LoginViewController Delegate
extension LoginViewController: LoginViewControllerDelegate {
    
    func didSelectLogin(_ viewController: UIViewController, email: String, password: String) {
        print("DID SELECT LOGIN; EMAIL = \(email); PASSWORD = \(password)")
    }
    
    func didSelectForgotPassword(_ viewController: UIViewController) {
        print("LOGIN DID SELECT FORGOT PASSWORD")
    }
    
    func loginDidSelectBack(_ viewController: UIViewController) {
        print("LOGIN DID SELECT BACK")
    }

    
}
