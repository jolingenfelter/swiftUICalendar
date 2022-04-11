//
//  MonthView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct MonthView<InMonthDay: View, TrailingDay: View>: View {
    @ObservedObject var dataStore: DataStore

    let month: Date
    let dayViews: (Date) -> InMonthDay
    let trailingDayViews: (Date) -> TrailingDay

    init(dataStore: DataStore,
         month: Date,
         @ViewBuilder dayViews: @escaping (Date) -> InMonthDay,
         @ViewBuilder trailingDayViews: @escaping (Date) -> TrailingDay) {
        self.dataStore = dataStore
        self.month = month
        self.dayViews = dayViews
        self.trailingDayViews = trailingDayViews
    }

    var body: some View {
        VStack {
            ForEach(dataStore.weeks(for: month), id: \.self) { week in
                WeekView(dataStore: dataStore,
                         week: week,
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
