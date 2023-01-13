//
//  Double+Extension.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 14.12.2022.
//

import Foundation

extension Double {
    var reducedAccuracy: String {
        String(format: "%.3f", self)
    }
}

extension Double {
    var RoundedToClosestInt: Int {
        Int(self.rounded())
    }
}
