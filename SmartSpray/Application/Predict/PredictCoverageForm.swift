//
//  PredictCoverageForm.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/15/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit
import Eureka

extension PredictCoverageViewController {
    func createForm() {
        /*
            The variables will take Imperial Units
            Form Vars
         Variable : Imperial | Metric
         
         Variable           Unit                Min    Max    Input
         Pressure           PSI     | kPA       30    180    60
         Tractor speed      MPH     | kmph      1.2    5.6    4
         GPA                Gallons | L         33    782    200
         Plant spacing      Inches  | cm        12    20    12
         Temp               F       | C         60    85    70
         Relative hum       Percent     | ??    22    90    40
         Wind speed         MPH     | kmph      0    14.5    5
         Gust speed         MPH     | kmph      0    17.5    7
        */
        
        let unit = UnitType.imperial
        
        var spraySettings = Section("Spray Settings")
        
        let pressureRow = DecimalRow("pressure") { row in
            let symbol = SmartSprayStandard.pressure(unitType: unit, valType: .min).unit.symbol
            let title = "Pressure (\(symbol))"
            let min = SmartSprayStandard.pressure(unitType: unit, valType: .min).value
            let max = SmartSprayStandard.pressure(unitType: unit, valType: .max).value
            let range = "\(min) - \(max) \(symbol)"
            let msg = "Pressure must be between \(range)"
            
            row.title = title
            row.placeholder = range
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: min, msg: msg, id: UUID.init(uuidString: title)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: max, msg: msg, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    //cell.textLabel?.numberOfLines
                }
        }
    
        let tractor_speedRow = DecimalRow("tractor_speed") { row in
            let symbol = SmartSprayStandard.tractor_speed(unitType: unit, valType: .min).unit.symbol
            let title = "Tractor Speed (\(symbol))"
            let min = SmartSprayStandard.tractor_speed(unitType: unit, valType: .min).value
            let max = SmartSprayStandard.tractor_speed(unitType: unit, valType: .max).value
            let range = "\(min) - \(max) \(symbol)"
            let msg = "Tractor Speed must be between \(range)"
            
            row.title = title
            row.placeholder = range
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: min, msg: msg, id: UUID.init(uuidString: title)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: max, msg: msg, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    //cell.textLabel?.numberOfLines
                }
        }
        
        let gpaRow = DecimalRow("gpa") { row in
            let symbol = SmartSprayStandard.gpa(unitType: unit, valType: .min).unit.symbol
            let title = "Gallons per Acre (\(symbol))"
            let min = SmartSprayStandard.gpa(unitType: unit, valType: .min).value
            let max = SmartSprayStandard.gpa(unitType: unit, valType: .max).value
            let range = "\(min) - \(max) \(symbol)"
            let msg = "GPA must be between \(range)"
            
            row.title = title
            row.placeholder = range
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: min, msg: msg, id: UUID.init(uuidString: title)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: max, msg: msg, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    //cell.textLabel?.numberOfLines
                }
        }
        
        let plant_spacingRow = DecimalRow("plant_spacing") { row in
            let symbol = SmartSprayStandard.gpa(unitType: unit, valType: .min).unit.symbol
            let title = "Plant Spacing (\(symbol))"
            let min = SmartSprayStandard.gpa(unitType: unit, valType: .min).value
            let max = SmartSprayStandard.gpa(unitType: unit, valType: .max).value
            let range = "\(min) - \(max) \(symbol)"
            let msg = "Plant Spacing must be between \(range)"
            
            row.title = title
            row.placeholder = range
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: min, msg: msg, id: UUID.init(uuidString: title)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: max, msg: msg, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    //cell.textLabel?.numberOfLines
                }
        }
        
        spraySettings += [
            pressureRow, tractor_speedRow, gpaRow, plant_spacingRow
        ]
        
        var weatherConditions = Section("Weather Conditions")
        
        let temperatureRow = DecimalRow("temperature") { row in
            let symbol = SmartSprayStandard.temperature(unitType: unit, valType: .min).unit.symbol
            let title = "Temperature (\(symbol))"
            let min = SmartSprayStandard.temperature(unitType: unit, valType: .min).value
            let max = SmartSprayStandard.temperature(unitType: unit, valType: .max).value
            let range = "\(min) - \(max) \(symbol)"
            let msg = "Temperature must be between \(range)"
            
            row.title = title
            row.placeholder = range
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: min, msg: msg, id: UUID.init(uuidString: title)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: max, msg: msg, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    //cell.textLabel?.numberOfLines
                }
        }
//
//        let relative_humidityRow = DecimalRow("relative_humidity") { row in
//            let title = SmartSprayStandard.relative(unitType: unit, valType: .min).description
//            let min = SmartSprayStandard.temperature(unitType: unit, valType: .min).value
//            let max = SmartSprayStandard.temperature(unitType: unit, valType: .max).value
//            let symbol = SmartSprayStandard.temperature(unitType: unit, valType: .min).unit.symbol
//            let range = "\(min) - \(max) \(symbol)"
//            let msg = "Relative Humidity must be between \(range)"
//
//            row.title = title
//            row.placeholder = range
//            row.add(rule: RuleRequired())
//            row.add(rule: RuleGreaterOrEqualThan(min: min, msg: msg, id: UUID.init(uuidString: title)?.uuidString))
//            row.add(rule: RuleSmallerOrEqualThan(max: max, msg: msg, id: UUID.init(uuidString: row.title!)?.uuidString))
//            row.validationOptions = .validatesOnChangeAfterBlurred
//            }.cellUpdate { (cell, row) in
//                if !row.isValid {
//                    cell.titleLabel?.textColor = .red
//                    //cell.textLabel?.numberOfLines
//                }
//        }
        let wind_speedRow = DecimalRow("wind_speed") { row in
            let symbol = SmartSprayStandard.wind_speed(unitType: unit, valType: .min).unit.symbol
            let title = "Wind Speed (\(symbol))"
            let min = SmartSprayStandard.wind_speed(unitType: unit, valType: .min).value
            let max = SmartSprayStandard.wind_speed(unitType: unit, valType: .max).value
            let range = "\(min) - \(max) \(symbol)"
            let msg = "Wind Speed must be between \(range)"
            
            row.title = title
            row.placeholder = range
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: min, msg: msg, id: UUID.init(uuidString: title)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: max, msg: msg, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    //cell.textLabel?.numberOfLines
                }
        }
        
        let gust_speedRow = DecimalRow("gust_speed") { row in
            let symbol = SmartSprayStandard.gust_speed(unitType: unit, valType: .min).unit.symbol
            let title = "Gust Speed (\(symbol))"
            let min = SmartSprayStandard.gust_speed(unitType: unit, valType: .min).value
            let max = SmartSprayStandard.gust_speed(unitType: unit, valType: .max).value
            let range = "\(min) - \(max) \(symbol)"
            let msg = "Gust Speed must be between \(range)"
            
            row.title = title
            row.placeholder = range
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: min, msg: msg, id: UUID.init(uuidString: title)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: max, msg: msg, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    //cell.textLabel?.numberOfLines
                }
        }
        
        weatherConditions += [
            temperatureRow, wind_speedRow, gust_speedRow
        ]
        
        var predictCoverageButtonSection = Section()
        
        let predictCoverageButtonRow = ButtonRow() { row in
            row.title = "Predict Coverage"
            row.tag = "predictCoverageButton"
            row.onCellSelection({ (cell, row) in
                self.predictButtonTouch()
            })
        }
        
        let saveButtonRow = ButtonRow() { row in
            row.title = "Save"
            row.tag = "saveButton"
            row.onCellSelection({ (cell, row) in
                self.saveButtonTouch()
            })
        }
        
        predictCoverageButtonSection += [predictCoverageButtonRow, saveButtonRow]

        var predictionLabelSection = Section("Predictions")
        predictionLabelSection.hidden = true
        predictionLabelSection.evaluateHidden()
        
        let predictionLabelRow = LabelRow() { row in
            row.title = ""
//            Estimated Spray Coverage for 9 Nozzles:
//            \nTeeJet AI 9502E: \()
//            \nAlbuz ATR 80 Green: \()
//            \nAlbuz ATR 80 Lilac: \()
//            \nAlbuz ATR 80 Orange: \()
//            \nTeeJet D2 w/ core 45: \()
//            \nTeeJet D3 w/ core 45: \()
//            \nTeeJet TJ60-8004: \()
//            \nTeeJet TP8002-VK: \()
//            \nTeeJet XR8003-VK: \()
//            """
            row.tag = "predictionLabel"
            row.cellSetup({ (cell, row) in
                cell.textLabel?.numberOfLines = 0
            })
            row.hidden = true
        }
        
        predictionLabelSection += [predictionLabelRow]
        
        let form = [spraySettings, weatherConditions, predictCoverageButtonSection, predictionLabelSection]
        
        self.form += form
        
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        animateScroll = true
        rowKeyboardSpacing = 50
    }
}

