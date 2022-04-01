//
//  MonthView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct MonthView<InMonthDay: View, TrailingDay: View>: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let dayViews: (Date) -> InMonthDay
    let trailingDayViews: (Date) -> TrailingDay

    init(month: Date,
         @ViewBuilder dayViews: @escaping (Date) -> InMonthDay,
         @ViewBuilder trailingDayViews: @escaping (Date) -> TrailingDay) {
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
