//
//  PredictCoverageViewController.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/12/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import Eureka

enum MetricRanges: Int {
    case sprayVolumeMin = 50
    case sprayVolumeMax = 90
    case tractorSpeedMin = 15
    case tractorSpeedMax = 35
    case temperatureMin = 10
    case temperatureMax = 37
    static var relativeHumidityMin = 15
    case relativeHumidityMax = 85
    case windSpeedMin = 0
    case windSpeedMax = 30
    case airPressureMin = 985
    case airPressureMax = 1025
}


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
