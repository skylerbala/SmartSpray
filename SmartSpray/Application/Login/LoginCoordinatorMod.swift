//
//  LoginCoordinator.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/27/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import ILLoginKit
import Alamofire

class LoginCoordinatorMod: ILLoginKit.LoginCoordinator {
    
    // MARK: - LoginCoordinator
    let domain = "http://localhost:8000/"
    
    override func start(animated: Bool = true) {
        super.start(animated: animated)
        configureAppearance()
    }
    
    override func finish(animated: Bool = true) {
        super.finish(animated: animated)
    }
    
    // MARK: - Setup
    
    // Customize LoginKit. All properties have defaults, only set the ones you want.
    func configureAppearance() {
        // Customize the look with background & logo images
        configuration.backgroundImage = #imageLiteral(resourceName: "navBarLogo")
        // mainLogoImage =
        // secondaryLogoImage =
        
        // Change colors
        configuration.tintColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1)
        configuration.errorTintColor = UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1)
        
        // Change placeholder & button texts, useful for different marketing style or language.
        configuration.shouldShowFacebookButton = false
        configuration.loginButtonText = "Sign In"
        configuration.signupButtonText = "Create Account"
        configuration.forgotPasswordButtonText = "Forgot password?"
        configuration.recoverPasswordButtonText = "Recover"
        configuration.namePlaceholder = "Name"
//        configuration.emailPlaceholder = "E-Mail"
//        configuration.passwordPlaceholder = "Password!"
//        configuration.repeatPasswordPlaceholder = "Confirm password!"
    }
    
    // MARK: - Completion Callbacks
    
    // Handle login via your API
    override func login(email: String, password: String) {
        let login_url = domain + "login/"
        
        let parameters = [
            "password": password,
            "email": email,
            ] as [String : Any?]

        let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as! MainViewController
        
        
        Alamofire.request(login_url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (res) in
            switch res.result {
            case .success(let data):
                if res.response?.statusCode == 200 {
                    let json = data as! NSDictionary
                    let token = json.value(forKey: "token") as! String!
                    
                    self.rootViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    tabBarVC.token = token
                }
                else {
                    // show errors
                }

            case .failure(let error):
                print("Error")
            }
        }
    }
    
    // Handle signup via your API
    override func signup(email: String, password: String) {
        let signup_url = domain + "api/users/"

        let parameters = [
            "password": password,
            "last_login": nil,
            "email": email,
            "is_active": true,
            "is_admin": false,
            ] as [String : Any?]

        
        Alamofire.request(signup_url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (res) in
            switch res.result {
            case .success:
                print("Success")
                
                self.login(email: email, password: password)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // Handle password recovery via your API
    override func recoverPassword(email: String) {
        print("Recover password with: email =\(email)")
    }
    
}
