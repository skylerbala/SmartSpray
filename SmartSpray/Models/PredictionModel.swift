//
//  PredictionModel.swift
//  SmartSpray
//
//  Created by Skyler Bala on 10/8/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation

enum PredictCoverageModel {
    enum nozzle {
        enum t1 {
            enum linear {
                static let intercept: Double = 10864
                static let plant_spacing: Double = -574.4525
                static let temperature: Double = -350.8498
                static let relative_humidity: Double = 21.3904
            }
            
            enum quadratic {
                static let gpa: Double = 0.0003
                static let plant_spacing: Double = 39.2617
                static let temperature: Double = 4.7938
                static let relative_humidity: Double = -0.4111
            }
            
            enum cubic {
                static let plant_spacing: Double = -0.8670
                static let temperature: Double = -0.0216
                static let relative_humidity: Double = 0.0025
                static let wind_speed: Double = 0.0358
                static let gust_speed: Double = 0.0358
            }
            
            static func sprayCoverage(pressure: Double, tractor_speed: Double, gpa: Double, plant_spacing: Double, temperature: Double, relative_humidity: Double, wind_speed: Double, gust_speed: Double) -> Double {
                
                let linearEffects = linear.intercept + linear.plant_spacing * plant_spacing + linear.temperature * temperature + linear.relative_humidity
                let quadraticEffects = quadratic.gpa * pow(gpa, 2) + quadratic.plant_spacing * pow(plant_spacing, 2) + quadratic.temperature * pow(temperature, 2) + quadratic.relative_humidity * pow(relative_humidity, 2)
                let cubicEffects = cubic.plant_spacing * pow(plant_spacing, 3) + cubic.temperature * pow(temperature, 3) + cubic.relative_humidity * pow(relative_humidity, 3) + cubic.wind_speed * pow(wind_speed, 3) + cubic.gust_speed * pow(gust_speed, 3)
                
                let spray_coverage = linearEffects + quadraticEffects + cubicEffects
                return spray_coverage
            }
        }
        enum a1 {
            
        }
        enum a2 {
            
        }
        enum a3 {
            
        }
        enum t2 {
            
        }
        enum t3 {
            
        }
        enum t4 {
            
        }
        enum t5 {
            
        }
        enum t6 {
            
        }
        
        
    }
}
