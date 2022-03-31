//
//  WeekView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    private var days: [Date] {
        return generateDays()
    }

    init(week: Date,
         @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: day, toGranularity: .month) {
                        self.content(day)
                    } else {
                        self.content(day).hidden()
                    }
                }
            }
        }
    }

    func generateDays() -> [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week) else {
            return []
        }

        return calendar.generateDatesByDay(within: weekInterval,
                                           components: DateComponents(hour: 0, minute: 0, second: 0))
    }
}

//struct WeekView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekView()
//    }
//}
