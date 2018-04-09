import Foundation

protocol TransactionsSummaryViewModelDelegate: class {
    func transactionsSummaryDidUpdateValues(viewModel: TransactionsSummaryViewModel)
}

class TransactionsSummaryViewModel {
    
    weak var delegate: TransactionsSummaryViewModelDelegate?
    var dateRange: DateRange {
        didSet {
            updateButtonText()
            updateAmountTexts()
            delegate?.transactionsSummaryDidUpdateValues(viewModel: self)
        }
    }
    
    private(set) var totalAmountText = ""
    private(set) var expensesAmountText = ""
    private(set) var incomesAmountText = ""
    private(set) var dateRangeButtonText = ""
    
    private let computingService: TransactionsComputingService
    private var observationTokens = [ObservationToken]()
    private var sum: TransactionsCompoundSum?
    
    init(computingService: TransactionsComputingService, dateRange: DateRange) {
        self.computingService = computingService
        self.dateRange = dateRange
        
        registerForNotifications()
        setupInitialValues()
    }
    
    private func registerForNotifications() {
        let token = computingService.observeTransactionsSumChanged { [unowned self] sum in
            self.sum = sum
            self.updateAmountTexts()
            self.delegate?.transactionsSummaryDidUpdateValues(viewModel: self)
        }
        observationTokens.append(token)
    }
    
    private func setupInitialValues() {
        do {
            updateButtonText()
            sum = try computingService.sum()
            updateAmountTexts()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateAmountTexts() {
        let sum = sumForSelectedDateRange ?? TransactionsSum.zero
        totalAmountText = "\(sum.total())"
        expensesAmountText = "\(sum.expenses)"
        incomesAmountText = "\(sum.incomes)"
    }
    
    private var sumForSelectedDateRange: TransactionsSum? {
        switch dateRange {
        case .today: return sum?.daily
        case .thisWeek: return sum?.weekly
        case .thisMonth: return sum?.monthly
        case .thisYear: return sum?.yearly
        case .allTime: return sum?.era
        }
    }
    
    private func updateButtonText() {
        dateRangeButtonText = dateRange.description
    }
}
