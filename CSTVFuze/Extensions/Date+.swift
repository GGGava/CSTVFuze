//
//  Date+.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import Foundation

extension Date {
    func formatInPortuguese() -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "pt_BR")
        
        let currentDate = Date()
        
        if calendar.isDateInToday(self) {
            formatter.dateFormat = "HH:mm"
            return "Hoje, " + formatter.string(from: self)
        }
        
        if calendar.isDate(self, equalTo: currentDate, toGranularity: .weekOfYear) {
            formatter.dateFormat = "EEE, HH:mm"
            return formatter.string(from: self)
        }
        
        formatter.dateFormat = "dd.MM HH:mm"
        return formatter.string(from: self)
    }
}
