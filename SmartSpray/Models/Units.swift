//
//  Units.swift
//  SmartSpray
//
//  Created by Skyler Bala on 10/8/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation

enum UnitType {
    case imperial
    case metric
}

enum ValueType {
    case min
    case max
}


enum SmartSprayStandard {
    static func pressure(unitType: UnitType, valType: ValueType) -> Measurement<UnitPressure> {
        switch unitType {
        case .imperial:
            switch valType {
            case .min: return Measurement(value: 30.0, unit: UnitPressure.poundsForcePerSquareInch)
            case .max: return Measurement(value: 180.0, unit: UnitPressure.poundsForcePerSquareInch)
            }
        case .metric:
            switch valType {
            case .min: return SmartSprayStandard.pressure(unitType: UnitType.imperial, valType: ValueType.min).converted(to: UnitPressure.kilopascals)
            case .max: return SmartSprayStandard.pressure(unitType: UnitType.imperial, valType: ValueType.max).converted(to: UnitPressure.kilopascals)
            }
        }
    }
    
    static func tractor_speed(unitType: UnitType, valType: ValueType) -> Measurement<UnitSpeed> {
        switch unitType {
        case .imperial:
            switch valType {
            case .min: return Measurement(value: 1.2, unit: UnitSpeed.milesPerHour)
            case .max: return Measurement(value: 5.6, unit: UnitSpeed.milesPerHour)
            }
        case .metric:
            switch valType {
            case .min: return SmartSprayStandard.tractor_speed(unitType: UnitType.imperial, valType: ValueType.min).converted(to: UnitSpeed.kilometersPerHour)
            case .max: return SmartSprayStandard.tractor_speed(unitType: UnitType.imperial, valType: ValueType.max).converted(to: UnitSpeed.kilometersPerHour)
            }
        }
    }
    
    static func gpa(unitType: UnitType, valType: ValueType) -> Measurement<UnitPressure> {
        switch unitType {
        case .imperial:
            switch valType {
            case .min: return Measurement(value: 33.0, unit: UnitPressure.poundsForcePerSquareInch)
            case .max: return Measurement(value: 782.0, unit: UnitPressure.poundsForcePerSquareInch)
            }
        case .metric:
            switch valType {
            case .min: return SmartSprayStandard.gpa(unitType: UnitType.imperial, valType: ValueType.min).converted(to: UnitPressure.kilopascals)
            case .max: return SmartSprayStandard.gpa(unitType: UnitType.imperial, valType: ValueType.max).converted(to: UnitPressure.kilopascals)
            }
        }
    }
    
    static func plant_spacing(unitType: UnitType, valType: ValueType) -> Measurement<UnitLength> {
        switch unitType {
        case .imperial:
            switch valType {
            case .min: return Measurement(value: 12.0, unit: UnitLength.inches)
            case .max: return Measurement(value: 20.0, unit: UnitLength.inches)
            }
        case .metric:
            switch valType {
            case .min: return SmartSprayStandard.plant_spacing(unitType: UnitType.imperial, valType: ValueType.min).converted(to: UnitLength.centimeters)
            case .max: return SmartSprayStandard.plant_spacing(unitType: UnitType.imperial, valType: ValueType.max).converted(to: UnitLength.centimeters)
            }
        }
    }
    
    static func temperature(unitType: UnitType, valType: ValueType) -> Measurement<UnitTemperature> {
        switch unitType {
        case .imperial:
            switch valType {
            case .min: return Measurement(value: 60.0, unit: UnitTemperature.fahrenheit)
            case .max: return Measurement(value: 85.0, unit: UnitTemperature.fahrenheit)
            }
        case .metric:
            switch valType {
            case .min: return SmartSprayStandard.temperature(unitType: UnitType.imperial, valType: ValueType.min).converted(to: UnitTemperature.celsius)
            case .max: return SmartSprayStandard.temperature(unitType: UnitType.imperial, valType: ValueType.max).converted(to: UnitTemperature.celsius)
            }
        }
    }
    
    //    static func relative_humidity(unitType: UnitType, valType: ValueType) -> Measurement<UnitTemperature> {
    //        switch unitType {
    //        case .imperial:
    //            switch valType {
    //            case .min: return Measurement(value: 60.0, unit: UnitTemperature.fahrenheit)
    //            case .max: return Measurement(value: 85.0, unit: UnitTemperature.fahrenheit)
    //            }
    //        case .metric:
    //            switch valType {
    //            case .min: return SmartSprayStandard.temperature(unitType: UnitType.imperial, valType: ValueType.min).converted(to: UnitTemperature.celsius)
    //            case .max: return SmartSprayStandard.temperature(unitType: UnitType.imperial, valType: ValueType.max).converted(to: UnitTemperature.celsius)
    //            }
    //        }
    //    }
    static func wind_speed(unitType: UnitType, valType: ValueType) -> Measurement<UnitSpeed> {
        switch unitType {
        case .imperial:
            switch valType {
            case .min: return Measurement(value: 0.0, unit: UnitSpeed.milesPerHour)
            case .max: return Measurement(value: 14.5, unit: UnitSpeed.milesPerHour)
            }
        case .metric:
            switch valType {
            case .min: return SmartSprayStandard.wind_speed(unitType: UnitType.imperial, valType: ValueType.min).converted(to: UnitSpeed.kilometersPerHour)
            case .max: return SmartSprayStandard.wind_speed(unitType: UnitType.imperial, valType: ValueType.max).converted(to: UnitSpeed.kilometersPerHour)
            }
        }
    }
    
    static func gust_speed(unitType: UnitType, valType: ValueType) -> Measurement<UnitSpeed> {
        switch unitType {
        case .imperial:
            switch valType {
            case .min: return Measurement(value: 0.0, unit: UnitSpeed.milesPerHour)
            case .max: return Measurement(value: 17.5, unit: UnitSpeed.milesPerHour)
            }
        case .metric:
            switch valType {
            case .min: return SmartSprayStandard.wind_speed(unitType: UnitType.imperial, valType: ValueType.min).converted(to: UnitSpeed.kilometersPerHour)
            case .max: return SmartSprayStandard.wind_speed(unitType: UnitType.imperial, valType: ValueType.max).converted(to: UnitSpeed.kilometersPerHour)
            }
        }
    }
}
