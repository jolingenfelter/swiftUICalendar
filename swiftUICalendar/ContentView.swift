//
//  ContentView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.calendar) static var calendar

    private static let today = Date()
    private static var oneYearFromToday: Date {
        return calendar.date(byAdding: .year, value: 1, to: today)!
    }
    private let year = DateInterval(start: today, end: oneYearFromToday)

    var body: some View {
        NavigationView {
            CalendarView(interval: year) { date in
                Text("30")
                    .hidden()
                    .padding(8)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(ContentView.calendar.component(.day, from: date)))
                    )
            } 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
