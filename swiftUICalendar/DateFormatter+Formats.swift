//
//  DateFormatter+Formats.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/31/22.
//

import Foundation

extension DateFormatter {
    static var monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()

    static var monthDayYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}
