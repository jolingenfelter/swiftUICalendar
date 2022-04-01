//
//  WeekView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct WeekView<DayView: View, TrailingDayView: View>: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let dayViews: (Date) -> DayView
    let trailingDayViews: (Date) -> TrailingDayView

    init(week: Date,
         @ViewBuilder dayViews: @escaping (Date) -> DayView,
         @ViewBuilder trailingDayViews: @escaping (Date) -> TrailingDayView) {
        self.week = week
        self.dayViews = dayViews
        self.trailingDayViews = trailingDayViews
    }

    var body: some View {
        let days = calendar.generateWeekDays(for: week)
        HStack {
            ForEach(days, id: \.self) { day in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: day, toGranularity: .month) {
                        self.dayViews(day)
                    } else {
                        self.trailingDayViews(day)
                    }
                }
            }
        }
    }
}

//struct WeekView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekView()
//    }
//}
