//
//  ScrollingCalendarView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct ScrollingCalendarView<InMonthDay: View,
                        TrailingDay: View,
                        Header: View,
                        Footer: View>: View {
    @Environment(\.calendar) var calendar

    private let interval: DateInterval
    private let dayViews: (Date) -> InMonthDay
    private let trailingDayViews: (Date) -> TrailingDay
    private let header: (Date) -> Header
    private let footer: (Date) -> Footer

    private var months: [Date] {
        return calendar.generateDates(within: interval,
                                      components: DateComponents(day: 1,
                                                                 hour: 0,
                                                                 minute: 0,
                                                                 second: 0))
    }

    init(interval: DateInterval,
         @ViewBuilder dayViews: @escaping (Date) -> InMonthDay,
         @ViewBuilder trailingDayViews: @escaping (Date) -> TrailingDay,
         @ViewBuilder header: @escaping (Date) -> Header,
         @ViewBuilder footer: @escaping (Date) -> Footer){
        self.interval = interval
        self.dayViews = dayViews
        self.trailingDayViews = trailingDayViews
        self.header = header
        self.footer = footer
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(months, id: \.self) { month in
                    Section {
                        MonthView(month: month,
                                  dayViews: self.dayViews,
                                  trailingDayViews: self.trailingDayViews)
                    } header: {
                        self.header(month)
                    } footer: {
                        self.footer(month)
                    }
                }
            }
        }
    }
}

//struct ScrollingCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollingCalendarView()
//    }
//}
