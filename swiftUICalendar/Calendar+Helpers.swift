//
//  Calendar+Helpers.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import Foundation

extension DateFormatter {
    static var monthDayYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

extension Calendar {
    func generateDatesByDay(within interval: DateInterval, components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(startingAfter: interval.start,
                       matching: components,
                       matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}
