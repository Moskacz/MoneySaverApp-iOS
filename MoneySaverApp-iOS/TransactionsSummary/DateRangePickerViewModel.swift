import Foundation
import MoneySaverAppCore

class DateRangePickerViewModel {
    
    private let calendar: CalendarProtocol
    
    init(calendar: CalendarProtocol) {
        self.calendar = calendar
    }
    
    var ranges: [(title: String, range: DateRange)] {
        let today = ("Today", DateRange.today)
        let thisMonth = ("\(calendar.monthName(forDate: calendar.now))", DateRange.thisMonth)
        let thisYear = ("\(calendar.yearName(forDate: calendar.now))", DateRange.thisYear)
        let allTime = ("All", DateRange.allTime)
        return [today, thisWeekRange, thisMonth, thisYear, allTime]
    }
    
    private var thisWeekRange: (title: String, range: DateRange) {
        let formatter = DateFormatters.formatter(forType: .shortDate)
        let dates = calendar.beginEndDaysOfWeek(forDate: calendar.now)
        let title = "Week (\(formatter.string(from: dates.start)) - \(formatter.string(from: dates.end)))"
        return (title, DateRange.thisWeek)
    }
}
