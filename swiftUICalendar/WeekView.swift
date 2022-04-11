//
//  WeekView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct WeekView<InMonthDay: View, TrailingDay: View>: View {
    @ObservedObject var dataStore: DataStore

    let week: Date
    let dayViews: (Date) -> InMonthDay
    let trailingDayViews: (Date) -> TrailingDay

    init(dataStore: DataStore,
         week: Date,
         @ViewBuilder dayViews: @escaping (Date) -> InMonthDay,
         @ViewBuilder trailingDayViews: @escaping (Date) -> TrailingDay) {
        self.dataStore = dataStore
        self.week = week
        self.dayViews = dayViews
        self.trailingDayViews = trailingDayViews
    }

    var body: some View {
        HStack {
            ForEach(dataStore.days(for: week), id: \.self) { day in
                HStack {
                    if dataStore.calendar.isDate(self.week, equalTo: day, toGranularity: .month) {
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
