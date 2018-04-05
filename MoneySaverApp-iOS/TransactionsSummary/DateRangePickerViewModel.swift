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
        let thisMonth = TitledDateRange(title: "Month - \(calendar.monthName(forDate: calendar.now))", range: .thisMonth)
        let thisYear = TitledDateRange(title: "Year - \(calendar.yearName(forDate: calendar.now))", range: .thisYear)
        let allTime = TitledDateRange(title: "All", range: .allTime)
        return [today, thisMonth, thisYear, allTime]
    }
}
