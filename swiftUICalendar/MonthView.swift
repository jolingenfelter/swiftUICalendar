//
//  MonthView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let content: (Date) -> DateView

    private var weeks: [Date] {
        return generateWeeks()
    }

    init(month: Date,
         @ViewBuilder content: @escaping (Date) -> DateView) {
        self.month = month
        self.content = content
    }

    var body: some View {
        VStack {
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }

    private func generateWeeks() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else {
            return []
        }

        return calendar.generateDatesByDay(within: monthInterval,
                                           components: DateComponents(hour: 0,
                                                                      minute: 0,
                                                                      second: 0,
                                                                      weekday: calendar.firstWeekday))
    }
}

//struct MonthView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthView()
//    }
//}
