//
//  Formatters.swift
//  iFisherman
//
//  Created by Wuz Good on 08.07.2022.
//

import Foundation

extension Double {
    func formattedKilograms() -> String {
        let weight = Measurement(value: self, unit: UnitMass.kilograms)
        
        let formatter = MassFormatter()
        formatter.numberFormatter.locale = .current
        formatter.numberFormatter.maximumFractionDigits = 2
        
        return formatter.string(fromValue: weight.value, unit: .kilogram)
    }
}

extension Formatter {
    static var deci: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        return formatter
    }
}

