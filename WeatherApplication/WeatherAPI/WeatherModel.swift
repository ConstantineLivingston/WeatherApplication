//
//  WeatherModel.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 15.12.2022.
//

import Foundation
import UIKit

struct WeatherModel {
    let city: String
    var hourlyList: [Forecast] = []
    var dailyList: [Forecast] = []
}

struct Forecast {
    let date: Date
    let tempMin: Int
    let tempMax: Int
    let humidity: Int
    let icon: String
    let wind: Wind
}

extension Forecast {
    var day: String {
        date.dayText.uppercased()
    }
}

struct Wind {
    let speed: Int
    let degree: Int
}


