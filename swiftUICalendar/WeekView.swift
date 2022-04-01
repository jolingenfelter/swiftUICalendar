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

    init(week: Date,
         @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    var body: some View {
        let days = calendar.generateWeekDays(for: week)
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
}

//struct WeekView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekView()
//    }
//}
