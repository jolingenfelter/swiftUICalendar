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

    @ObservedObject var dataStore: DataStore

    private let dayViews: (Date) -> InMonthDay
    private let trailingDayViews: (Date) -> TrailingDay
    private let header: (Date) -> Header
    private let footer: (Date) -> Footer

    
    init(dataStore: DataStore,
         @ViewBuilder dayViews: @escaping (Date) -> InMonthDay,
         @ViewBuilder trailingDayViews: @escaping (Date) -> TrailingDay,
         @ViewBuilder header: @escaping (Date) -> Header,
         @ViewBuilder footer: @escaping (Date) -> Footer){
        self.dataStore = dataStore
        self.dayViews = dayViews
        self.trailingDayViews = trailingDayViews
        self.header = header
        self.footer = footer
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(dataStore.months, id: \.self) { month in
                    Section {
                        MonthView(month: month,
                                  dayViews: self.dayViews,
                                  trailingDayViews: self.trailingDayViews)
                        .onAppear() {
                            dataStore.loadMoreMonthsIfNeeded(currentDate: month)
                        }
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
