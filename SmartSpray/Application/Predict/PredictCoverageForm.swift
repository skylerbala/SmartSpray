//
//  PredictCoverageForm.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/15/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import Eureka

extension PredictCoverageViewController {
    func createForm() {
        var spraySettings = Section("Spray Settings")
        
        
        let sprayVolumeRow = IntRow() { row in
            row.title = "Spray Volume"
            row.tag = "spray_volume"
            let units = "\(MetricRanges.sprayVolumeMin.rawValue)-\(MetricRanges.sprayVolumeMax.rawValue) L/ha"
            row.placeholder = units
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: MetricRanges.sprayVolumeMin.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: MetricRanges.sprayVolumeMax.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
        }
        
        let adjuvantRow = SwitchRow() { row in
            row.title = "Adjuvant: On"
            row.tag = "adjuvant"
            row.value = true
            }.onChange { (row) in
                row.title = row.value! ? "Adjuvant: On" : "Adjuvant: Off"
                row.updateCell()
        }
        
        let tractorSpeedRow = IntRow() { row in
            row.title = "Tractor Speed"
            row.tag = "tractor_speed"
            let units = "\(MetricRanges.tractorSpeedMin.rawValue)-\(MetricRanges.tractorSpeedMax.rawValue) L/ha"
            row.placeholder = units
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: MetricRanges.tractorSpeedMin.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: MetricRanges.tractorSpeedMax.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
        }
        
        let nozzleSizeRow = SegmentedRow<Int>() { row in
            row.title = "Nozzle Size"
            row.tag = "nozzle_size"
            row.options = [1, 2, 3, 4]
            row.value = 1
        }
        
        
        spraySettings += [
            sprayVolumeRow, adjuvantRow, tractorSpeedRow, nozzleSizeRow
        ]
        
        var weatherConditions = Section("Weather Conditions")
        
        let temperatureRow = IntRow() { row in
            row.title = "Temperature"
            row.tag = "temperature"
            let units = "\(MetricRanges.temperatureMin.rawValue)-\(MetricRanges.temperatureMax.rawValue) L/ha"
            let message = "Temperature must be between \(units)"
            row.placeholder = units
            row.add(rule: RuleRequired(msg: "Required", id:  UUID.init(uuidString: row.title!)?.uuidString))
            row.add(rule: RuleGreaterOrEqualThan(min: MetricRanges.temperatureMin.rawValue, msg: message, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: MetricRanges.temperatureMax.rawValue, msg: message, id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellSetup { (cell, row) in
                cell.textLabel?.numberOfLines = 0
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    let errors = row.validationErrors.map({ (error) -> String in
                        return "\n\(error.msg)"
                    })
                    
                    let error = errors.joined(separator: "")
                    
                    row.title = "Temperature" + error
                }
                else {
                    row.title = "Temperature"
                    cell.titleLabel?.textColor = .black
                }
        }
        
        let relativeHumidityRow = IntRow() { row in
            row.title = "Relative Humidity"
            row.tag = "relative_humidity"
            let units = "\(MetricRanges.relativeHumidityMin)-\(MetricRanges.relativeHumidityMax.rawValue) L/ha"
            row.placeholder = units
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: MetricRanges.relativeHumidityMin, msg: "Relative humidity must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: MetricRanges.relativeHumidityMax.rawValue, msg: "Relative humidity must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    let errors = row.validationErrors.map({ (error) -> String in
                        return "\n\(error.msg)"
                    })
                    
                    let error = errors.joined(separator: "")
                    
                    row.title = "Relative Humidity" + error
                }
                else {
                    row.title = "Relative Humidity"
                    cell.titleLabel?.textColor = .black
                }
        }
        
        let windSpeedRow = IntRow() { row in
            row.title = "Wind Speed"
            row.tag = "wind_speed"
            let units = "\(MetricRanges.windSpeedMin.rawValue)-\(MetricRanges.windSpeedMax.rawValue) L/ha"
            row.placeholder = units
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: MetricRanges.windSpeedMin.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: MetricRanges.windSpeedMax.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
        }
        
        let barometricPressureRow = IntRow() { row in
            row.title = "Barometric Pressure"
            row.tag = "air_pressure"
            let units = "\(MetricRanges.airPressureMin.rawValue)-\(MetricRanges.airPressureMax.rawValue) L/ha"
            row.placeholder = units
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: MetricRanges.airPressureMin.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: MetricRanges.airPressureMax.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    //cell.textLabel?.numberOfLines
                }
        }
        
        weatherConditions += [
            temperatureRow, relativeHumidityRow, windSpeedRow, barometricPressureRow
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
            row.title = "Estimated Spray Coverage for 4 Nozzles: \nAIX: 12.12% \nTP: 3.55% \nTT: 15.1% \nXR: 1.52%"
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
