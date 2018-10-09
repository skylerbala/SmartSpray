//
//  PredictCoverageViewController.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/12/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import Eureka

class PredictCoverageViewController: FormViewController {

    let estimatedCoverageLabel: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createForm()
        setViews()
        navigationController?.setSmartSprayNavigationBar()
    }
    
    
    
    
}
