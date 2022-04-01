//
//  MonthView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct MonthView<DayViews: View, TrailingDayViews: View>: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let dayViews: (Date) -> DayViews
    let trailingDayViews: (Date) -> TrailingDayViews

    init(month: Date,
         @ViewBuilder dayViews: @escaping (Date) -> DayViews,
         @ViewBuilder trailingDayViews: @escaping (Date) -> TrailingDayViews) {
        self.month = month
        self.dayViews = dayViews
        self.trailingDayViews = trailingDayViews
    }

    var body: some View {
        let weeks = calendar.generateWeeks(for: month)

        VStack {
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week,
                         dayViews: self.dayViews,
                         trailingDayViews: self.trailingDayViews)
            }
        }
    }
}

//struct MonthView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthView()
//    }
//}
