//
//  CalendarView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView

    private var months: [Date] {
        return calendar.generateDatesByDay(within: interval, components: DateComponents(day: 1, hour: 0, minute: 0, second: 0))
    }

    init(interval: DateInterval,
         @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, content: self.content)
                }
            }
        }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
