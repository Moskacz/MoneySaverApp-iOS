import Foundation

protocol TransactionsSummaryViewModelDelegate: class {
    func transactionsSummaryDidUpdateValues(viewModel: TransactionsSummaryViewModel)
}

class TransactionsSummaryViewModel {
    
    weak var delegate: TransactionsSummaryViewModelDelegate?
    private(set) var totalAmountText = ""
    private(set) var expensesAmountText = ""
    private(set) var incomesAmountText = ""
    private(set) var dateRangeButtonText = "Today"
    
    private let computingService: TransactionsComputingService
    private var observationTokens = [ObservationToken]()
    
    init(computingService: TransactionsComputingService) {
        self.computingService = computingService
        registerForNotifications()
        setupInitialValues()
    }
    
    private func registerForNotifications() {
        let token = computingService.observeTransactionsSumChanged { [unowned self] sum in
            self.setupAmountTexts(sum: sum)
            self.delegate?.transactionsSummaryDidUpdateValues(viewModel: self)
        }
        observationTokens.append(token)
    }
    
    private func setupInitialValues() {
        do {
            setupAmountTexts(sum: try computingService.sum())
        
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupAmountTexts(sum: TransactionsCompoundSum) {
        totalAmountText = "\(sum.monthly.total())"
        expensesAmountText = "\(sum.monthly.expenses)"
        incomesAmountText = "\(sum.monthly.incomes)"
    }
}
