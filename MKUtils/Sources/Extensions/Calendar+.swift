//
//  Calendar+.swift
//

import Foundation

public extension Calendar {
    @available(macOS 10.12, *)
    func intervalOfWeek(for date: Date) -> DateInterval? {
        dateInterval(of: .weekOfYear, for: date)
    }
    
    @available(macOS 10.12, *)
    func startOfWeek(for date: Date) -> Date? {
        intervalOfWeek(for: date)?.start
    }
    
    @available(macOS 10.12, *)
    func daysWithSameWeekOfYear(as date: Date = Date()) -> [Date] {
        guard let startOfWeek = startOfWeek(for: date) else {
            return []
        }
        
        return (0 ... 6).reduce(into: []) { result, daysToAdd in
            result.append(Calendar.current.date(byAdding: .day, value: daysToAdd, to: startOfWeek))
        }
        .compactMap { $0 }
    }
}

public extension Calendar {

    ///
    ///
    ///        let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///        Calendar.current.numberOfDaysInMonth(for: date) -> 31
    ///
    /// - Parameter date: the date form which the number of days in month is calculated.
    /// - Returns: The number of days in the month of 'Date'.
    func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)!.count
    }

}
