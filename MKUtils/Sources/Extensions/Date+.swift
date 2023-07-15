import Foundation

public extension Date {
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: self)!
    }
}

public extension Date {
    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier) // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
    }

    /// Era.
    ///
    ///        Date().era -> 1
    ///
    var era: Int {
        return calendar.component(.era, from: self)
    }

    #if !os(Linux)
    /// Quarter.
    ///
    ///        Date().quarter -> 3 // date in third quarter of the year.
    ///
    var quarter: Int {
        let month = Double(calendar.component(.month, from: self))
        let numberOfMonths = Double(calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month/numberOfMonthsInQuarter))
    }
    #endif

    /// Week of year.
    ///
    ///        Date().weekOfYear -> 2 // second week in the year.
    ///
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }

    /// Week of month.
    ///
    ///        Date().weekOfMonth -> 3 // date is in third week of the month.
    ///
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }

    /// Year.
    ///
    ///        Date().year -> 2017
    ///
    ///        var someDate = Date()
    ///        someDate.year = 2000 // sets someDate's year to 2000
    ///
    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }

    /// Month.
    ///
    ///     Date().month -> 1
    ///
    ///     var someDate = Date()
    ///     someDate.month = 10 // sets someDate's month to 10.
    ///
    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }

    /// Day.
    ///
    ///     Date().day -> 12
    ///
    ///     var someDate = Date()
    ///     someDate.day = 1 // sets someDate's day of month to 1.
    ///
    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }

    /// Weekday.
    ///
    ///     Date().weekday -> 5 // fifth day in the current week.
    ///
    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }
    /// Weekday.
    ///
    ///     Date().weekOfMonthNumber -> 5
    ///
    var weekOfMonthNumber: Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    /// Weekday.
    ///
    ///     Date().weekOfYearNumber -> 5
    ///
    var weekOfYearNumber: Int {
        return Calendar.current.component(.weekOfYear, from: self)
    }

    /// Hour.
    ///
    ///     Date().hour -> 17 // 5 pm
    ///
    ///     var someDate = Date()
    ///     someDate.hour = 13 // sets someDate's hour to 1 pm.
    ///
    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }

    /// Minutes.
    ///
    ///     Date().minute -> 39
    ///
    ///     var someDate = Date()
    ///     someDate.minute = 10 // sets someDate's minutes to 10.
    ///
    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }

    /// Seconds.
    ///
    ///     Date().second -> 55
    ///
    ///     var someDate = Date()
    ///     someDate.second = 15 // sets someDate's seconds to 15.
    ///
    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }

    /// Nanoseconds.
    ///
    ///     Date().nanosecond -> 981379985
    ///
    ///     var someDate = Date()
    ///     someDate.nanosecond = 981379985 // sets someDate's seconds to 981379985.
    ///
    var nanosecond: Int {
        get {
            return calendar.component(.nanosecond, from: self)
        }
        set {
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(newValue) else { return }

            let currentNanoseconds = calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds

            if let date = calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }

    /// Milliseconds.
    ///
    ///     Date().millisecond -> 68
    ///
    ///     var someDate = Date()
    ///     someDate.millisecond = 68 // sets someDate's nanosecond to 68000000.
    ///
    var millisecond: Int {
        get {
            return calendar.component(.nanosecond, from: self) / 1_000_000
        }
        set {
            let nanoSeconds = newValue * 1_000_000
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(nanoSeconds) else { return }

            if let date = calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }

    /// Check if date is in future.
    ///
    ///     Date(timeInterval: 100, since: Date()).isInFuture -> true
    ///
    var isInFuture: Bool {
        return self > Date()
    }

    /// Check if date is in past.
    ///
    ///     Date(timeInterval: -100, since: Date()).isInPast -> true
    ///
    var isInPast: Bool {
        return self < Date()
    }

    /// Check if date is within today.
    ///
    ///     Date().isInToday -> true
    ///
    var isInToday: Bool {
        return calendar.isDateInToday(self)
    }

    /// Check if date is within yesterday.
    ///
    ///     Date().isInYesterday -> false
    ///
    var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }

    /// Check if date is within tomorrow.
    ///
    ///     Date().isInTomorrow -> false
    ///
    var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }

    /// Check if date is within a weekend period.
    var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }

    /// Check if date is within a weekday period.
    var isWorkday: Bool {
        return !calendar.isDateInWeekend(self)
    }

    /// Check if date is within the current week.
    var isInCurrentWeek: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    /// Check if date is within the current month.
    var isInCurrentMonth: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    /// Check if date is within the current year.
    var isInCurrentYear: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    var isLeapMonth: Bool {
        if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) {
            return true
        }
        else {
            return false
        }
    }
    
    var numberOfMonth: Int {
        let numberList = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        if isLeapMonth && month == 2 {
            return 29
        }
        else {
            return numberList[month]
        }
    }
    
    var firstWeekday: Int {
        var dateComponent = DateComponents()
        dateComponent.year = Calendar.current.component(.year, from: self)
        dateComponent.month = Calendar.current.component(.month, from: self)
        dateComponent.day = 1
        dateComponent.weekday = Calendar.current.component(.weekday, from: Calendar.current.date(from: dateComponent)!)
        /// 리턴값 : 일 - 토 -> 0 - 6
        return dateComponent.weekday! - 1
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}

public extension Date {

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }

    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }

    var isInThisYear: Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek: Bool { isInSameWeek(as: Date()) }

    var isInTheFuture: Bool { self > Date() }
    var isInThePast: Bool { self < Date() }
}

public extension Date {

    ///
    ///     let date = Date() // "Jan 12, 2017, 7:14 PM"
    ///     let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
    ///     let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
    ///     let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
    ///
    /// - Parameter component: calendar component to get date at the beginning of.
    /// - Returns: date at the beginning of calendar component (if applicable).
    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]

            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: self))
    }
    
    func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date

        case .minute:
            var date = adding(.minute, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .hour:
            var date = adding(.hour, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .day:
            var date = adding(.day, value: 1)
            date = calendar.startOfDay(for: date)
            date.add(.second, value: -1)
            return date

        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = calendar.date(from:
                calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date

        case .month:
            var date = adding(.month, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .year:
            var date = adding(.year, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year], from: date))!
            date = after.adding(.second, value: -1)
            return date

        default:
            return nil
        }
    }
    
    private mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
}

public extension Date {
    func toString(
        locale: Locale = Locale.current, // Locale(identifier: "en_US_POSIX") ko_kr
        timeZone: TimeZone? = TimeZone.current, // TimeZone(abbreviation: "GMT") KST
        format: String = "yyyy/MM/dd HH:mm:ss"
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    func iso8601String(
        locale: Locale = Locale.current, // Locale(identifier: "en_US_POSIX") ko_kr
        timeZone: TimeZone? = TimeZone.current // TimeZone(abbreviation: "GMT") KST
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" // iso8601
        
        return dateFormatter.string(from: self).appending("Z")
    }
    
    init?(
        dateString: String,
        locale: Locale = Locale.current, // Locale(identifier: "en_US_POSIX") ko_kr
        timeZone: TimeZone? = TimeZone.current, // TimeZone(abbreviation: "GMT") KST
        dateFormat: String? = nil
    ) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        if let dateFormat = dateFormat {
            dateFormatter.dateFormat = dateFormat
        }
        else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  // iso8601
        }
        
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        self = date
    }
    
}
/**
 10000.asString(style: .positional)  // 2:46:40
 10000.asString(style: .abbreviated) // 2h 46m 40s
 10000.asString(style: .short)       // 2 hr, 46 min, 40 sec
 10000.asString(style: .full)        // 2 hours, 46 minutes, 40 seconds
 10000.asString(style: .spellOut)    // two hours, forty-six minutes, forty seconds
 10000.asString(style: .brief)       // 2hr 46min 40sec
 */
public extension Double {
    func toTimeFormat(
        locale: Locale = Locale.current, // Locale(identifier: "en_US_POSIX") ko_kr
        style: DateComponentsFormatter.UnitsStyle,
        allowedUnits: NSCalendar.Unit = [.hour, .minute] // .second, .nanosecond
    ) -> String {
        
        var calendar = Calendar.current
        calendar.locale = locale
//        calendar.timeZone = TimeZone(abbreviation: "KST")
        let formatter = DateComponentsFormatter()
        formatter.calendar = calendar
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
    
    /// second 기준
    var toTime: String {
        let hour = Int(self) / 3600
        let minute = Int(self) / 60 % 60

        // return formated string
        return String(format: "%02d:%02d", hour, minute)
    }
    
    /// second 기준
    var toTimeKR: String {
        let hour = Int(self) / 3600
        let minute = Int(self) / 60 % 60

        // return formated string
        return String(format: "%02d시 %02d분", hour, minute)
    }
    
}

public extension String {

    var double: Double {
        return Double(self) ?? 0
    }

    var secondFromString: Double {
        let components: Array = self.components(separatedBy: ":")
        let hours = components[0].double
        let minutes = components[1].double
//        let seconds = components[2].integer
        return Double((hours * 60 * 60) + (minutes * 60))
    }
    
}

public extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func firstDayOfTheMonth() -> Date {
        return Calendar.current.date(from:
            Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
    func endDayOfTheMonth() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    func getAllDays() -> [Date] {
        var days = [Date]()

        let calendar = Calendar.current

        let range = calendar.range(of: .day, in: .month, for: self)!

        var day = firstDayOfTheMonth()

        for _ in 1...range.count {
            days.append(day)
            day.add(.day, value: 1)
        }

        return days
    }
}

public extension Date {
    func localDate() -> Date {
        let nowUTC = self
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else { return Date() }

        return localDate
    }
}
