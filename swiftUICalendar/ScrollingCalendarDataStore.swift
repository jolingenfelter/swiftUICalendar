//
//  ScrollingCalendarDataStore.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 4/1/22.
//

import Foundation

class DataStore: ObservableObject {
    @Published var months: [Date] = []

    let calendar: Calendar

    init(calendar: Calendar) {
        self.calendar = calendar

        loadMoreMonths(currentDate: nil)
    }

    func loadMoreMonthsIfNeeded(currentDate: Date?) {
        guard let currentDate = currentDate else {
            loadMoreMonths(currentDate: nil)
            return
        }

        let scrollIndexToStartLoading = months.count - 2
        if months[scrollIndexToStartLoading] == currentDate {
            loadMoreMonths(currentDate: currentDate)
        }
    }

    private func loadMoreMonths(currentDate: Date?) {
        let startDate = months.last ?? Date()

        guard let oneYearFromStartDate = calendar.date(byAdding: .year, value: 1, to: startDate) else {
            return
        }

        let nextYearInMonths = calendar.generateMonths(within: oneYearFromStartDate)
        months.append(contentsOf: nextYearInMonths)
    }

    func weeks(for month: Date) -> [Date] {
        return calendar.generateWeeks(for: month)
    }

    func days(for week: Date) -> [Date] {
        return calendar.generateWeekDays(for: week)
    }
}
