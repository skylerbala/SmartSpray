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
        setNavigationBar()

    }
    
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
    
    
    func createForm() {
        var spraySettings = Section("Spray Settings")
        
        
        let sprayVolumeRow = IntRow() { row in
            row.title = "Spray Volume"
            row.tag = "sprayVolume"
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
            row.tag = "hasAdjuvant"
            row.value = true
            }.onChange { (row) in
                row.title = row.value! ? "Adjuvant: On" : "Adjuvant: Off"
                row.updateCell()
        }
        
        let tractorSpeedRow = IntRow() { row in
            row.title = "Tractor Speed"
            row.tag = "tractorSpeed"
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
            row.tag = "nozzleSize"
            row.options = [1, 2, 3, 4]
            row.value = 1
        }
        
        
        spraySettings += [
            sprayVolumeRow, adjuvantRow, tractorSpeedRow, nozzleSizeRow
        ]
        
        var weatherConditions = Section("Weather Conditions")
        
        let temperatureRow = IntRow() { row in
            row.title = "Temperature"
            row.tag = "temperatue"
            let units = "\(MetricRanges.temperatureMin.rawValue)-\(MetricRanges.temperatureMax.rawValue) L/ha"
            let message = "Spray volume must be between \(units)"
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
            }
        
        let relativeHumidityRow = IntRow() { row in
            row.title = "Relative Humidity"
            row.tag = "relative humidity"
            let units = "\(MetricRanges.relativeHumidityMin)-\(MetricRanges.relativeHumidityMax.rawValue) L/ha"
            row.placeholder = units
            row.add(rule: RuleRequired())
            row.add(rule: RuleGreaterOrEqualThan(min: MetricRanges.relativeHumidityMin, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.add(rule: RuleSmallerOrEqualThan(max: MetricRanges.relativeHumidityMax.rawValue, msg: "Spray volume must be between \(units)", id: UUID.init(uuidString: row.title!)?.uuidString))
            row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    
                }
            }
        
        let windSpeedRow = IntRow() { row in
            row.title = "Wind Speed"
            row.tag = "windSpeed"
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
            row.tag = "airPressure"
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
        
        predictCoverageButtonSection += [predictCoverageButtonRow]

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
        rowKeyboardSpacing = 20
    }
    
    

}
