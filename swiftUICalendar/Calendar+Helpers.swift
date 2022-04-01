//
//  Calendar+Helpers.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import Foundation

extension Calendar {
    func generateDates(within interval: DateInterval,
                            components: DateComponents) -> [Date] {
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

    func days(for month: Date) -> [Date] {
        guard let monthInterval = dateInterval(of: .month, for: month),
              let monthFirstWeek = dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }

        return generateDates(within: DateInterval(start: monthFirstWeek.start,
                                                       end: monthLastWeek.end),
                                  components: DateComponents(hour: 0,
                                                             minute: 0,
                                                             second: 0))
    }

    func generateWeekDays(for month: Date) -> [Date] {
        guard let week = dateInterval(of: .weekOfMonth, for: month) else {
            return []
        }

        return generateDates(within: week,
                             components: DateComponents(hour: 0,
                                                        minute: 0,
                                                        second: 0))
    }

    func generateWeeks(for month: Date) -> [Date] {
        guard let monthInterval = dateInterval(of: .month, for: month) else {
            return []
        }
        
        return generateDates(within: monthInterval,
                                           components: DateComponents(hour: 0,
                                                                      minute: 0,
                                                                      second: 0,
                                                                      weekday: self.firstWeekday))
    }
}
