//
//  ContentView.swift
//  swiftUICalendar
//
//  Created by Joanna Lingenfelter on 3/30/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.calendar) static var calendar
    @StateObject var dataStore: DataStore

    init() {
        _dataStore = StateObject(wrappedValue: DataStore(calendar: ContentView.calendar))
    }

    var body: some View {
        NavigationView {
            ScrollingCalendarView(dataStore: dataStore) { date in
                Text("30")
                    .hidden()
                    .padding(8)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(ContentView.calendar.component(.day, from: date)))
                    )
            } trailingDayViews: { date in
                Text("30")
                    .hidden()
                    .padding(8)
                    .foregroundColor(.gray)
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(ContentView.calendar.component(.day, from: date)))
                    )
            } header: { month in
                Text(DateFormatter.monthYearFormatter.string(from: month))
                    .foregroundColor(.green)
                    .font(.largeTitle).bold()
            } footer: { _ in
                Spacer(minLength: 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
