import Foundation

struct TitledDateRange {
    let title: String
    let range: DateRange
}

class DateRangePickerViewModel {
    
    private let calendar: CalendarProtocol
    
    init(calendar: CalendarProtocol) {
        self.calendar = calendar
    }
    
    var ranges: [TitledDateRange] {
        let today = TitledDateRange(title: "Today", range: .today)
        let thisMonth = TitledDateRange(title: "\(calendar.monthName(forDate: calendar.now))", range: .thisMonth)
        let thisYear = TitledDateRange(title: "\(calendar.yearName(forDate: calendar.now))", range: .thisYear)
        let allTime = TitledDateRange(title: "All", range: .allTime)
        return [today, thisWeekRange, thisMonth, thisYear, allTime]
    }
    
    private var thisWeekRange: TitledDateRange {
        let formatter = DateFormatters.formatter(forType: .shortDate)
        let dates = calendar.beginEndDaysOfWeek(forDate: calendar.now)
        let title = "Week (\(formatter.string(from: dates.start)) - \(formatter.string(from: dates.end)))"
        return TitledDateRange(title: title, range: .thisWeek)
    }
}
