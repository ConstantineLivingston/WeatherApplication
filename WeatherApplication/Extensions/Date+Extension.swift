//
//  Date+Extension.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 14.12.2022.
//

import Foundation

extension Date {
    var dayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
}

extension Date {
    var isIn24HourRange: Bool {
        let start = Date.now
        let end = Date(timeInterval: 86400, since: start)
        return (start...end).contains(self)
    }
}

extension Date {
    func get(components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
}
