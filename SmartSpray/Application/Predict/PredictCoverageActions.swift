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
            
            guard let pressure = valuesDict["pressure"] as! Double!,
            let tractor_speed = valuesDict["tractor_speed"] as! Double!,
            let gpa = valuesDict["gpa"] as! Double!,
            let plant_spacing = valuesDict["plant_spacing"] as! Double!,
            let temperature = valuesDict["temperature"] as! Double!,
            let relative_humidity = valuesDict["relative_humidity"] as! Double!,
            let wind_speed = valuesDict["wind_speed"] as! Double!,
                let gust_speed = valuesDict["gust_speed"] as! Double!
            else { return }
            
            let spray_coverage: Double = PredictCoverageModel.nozzle.t1.sprayCoverage(pressure: pressure, tractor_speed: tractor_speed, gpa: gpa, plant_spacing: plant_spacing, temperature: temperature, relative_humidity: relative_humidity, wind_speed: wind_speed, gust_speed: gust_speed)
            
            estimatedCoverageLabel.text =
            """
            Estimated Spray Coverage for 9 Nozzles:
            \nTeeJet AI 9502E: \(spray_coverage)
            \nAlbuz ATR 80 Green: \(value)
            \nAlbuz ATR 80 Lilac: \(value)
            \nAlbuz ATR 80 Orange: \(value)
            \nTeeJet D2 w/ core 45: \(value)
            \nTeeJet D3 w/ core 45: \(value)
            \nTeeJet TJ60-8004: \(value)
            \nTeeJet TP8002-VK: \(value)
            \nTeeJet XR8003-VK: \(value)
            """
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
