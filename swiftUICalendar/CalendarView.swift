//
//  CalendarView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct CalendarView<DayView: View, TrailingDayView: View>: View {
    @Environment(\.calendar) var calendar

    private let interval: DateInterval
    private let dayViews: (Date) -> DayView
    private let trailingDayViews: (Date) -> TrailingDayView

    private var months: [Date] {
        return calendar.generateDates(within: interval, components: DateComponents(day: 1, hour: 0, minute: 0, second: 0))
    }

    init(interval: DateInterval,
         @ViewBuilder dayViews: @escaping (Date) -> DayView,
         @ViewBuilder trailingDayViews: @escaping(Date) -> TrailingDayView){
        self.interval = interval
        self.dayViews = dayViews
        self.trailingDayViews = trailingDayViews
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
                        VStack {
                            Spacer(minLength: 15)
                            Text(DateFormatter.monthFormatter.string(from: month))
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                    } footer: {
                        Spacer(minLength: 15)
                    }
                }
            }
        }
    }

    private func makeDates() -> [(month: Date, days: [Date])] {
        calendar.generateDates(within: interval,
                               components: DateComponents(day: 1,
                                                          hour: 0,
                                                          minute: 0,
                                                          second: 0))
            .map { ($0, calendar.days(for: $0))}
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
