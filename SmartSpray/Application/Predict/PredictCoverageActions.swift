//
//  PredictCoverageActions.swift
//  SmartSpray
//
//  Created by Skyler Bala on 10/1/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import Alamofire

extension PredictCoverageViewController {
    func predictButtonTouch() {
        let errors = form.validate()
        let predictionCoverageLabel = form.allRows.last as! LabelRow
        let predictionCoverageLabelSection = form.allSections.last as! Section
        
        if errors == [] {
            let valuesDict = form.values()
            estimatedCoverageLabel.text = "Estimated Spray Coverage for 4 Nozzles: \nAIX: 12.12% \nTP: 3.55% \nTT: 15.1% \nXR: 1.52%"
            predictionCoverageLabel.title = estimatedCoverageLabel.text
            predictionCoverageLabel.hidden = false
            predictionCoverageLabel.evaluateHidden()
            
            predictionCoverageLabelSection.hidden = false
            predictionCoverageLabelSection.evaluateHidden()
        }
        else {
            predictionCoverageLabel.hidden = true
            predictionCoverageLabel.evaluateHidden()
            
            predictionCoverageLabelSection.hidden = true
            predictionCoverageLabelSection.evaluateHidden()
        }
    }
    
    func saveButtonTouch() {
        let formData = form.values()
        let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as! MainViewController
        let token = tabBarVC.token
        
        let savePredictURL = "http://localhost:8000/api/prediction/"
        
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.string(from: Date())
        
        
        
        let parameters = [
            "date": date,
            "spray_volume": formData["spray_volume"],
            "adjuvant": formData["adjuvant"],
            "tractor_speed": formData["tractor_speed"],
            "nozzle_size": formData["nozzle_size"],
            "temperature": formData["temperature"],
            "relative_humidity": formData["relative_humidity"],
            "wind_speed": formData["wind_speed"],
            "pressure": formData["pressure"],
            "user": nil
            ] as [String : Any?]
        
        let headers = [
            "Authorization": "Token \(token)"
        ]
        
        
        Alamofire.request(savePredictURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (res) in
            switch res.result {
            case .success:
                print("Success")
                
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        
    }
}
