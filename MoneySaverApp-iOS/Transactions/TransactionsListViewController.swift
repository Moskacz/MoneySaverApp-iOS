//
//  TransactionsListViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import RxSwift

class TransactionsListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let storyboardId = "TransactionsListViewController"
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: TransactionsListViewModel!
    
    private let transactionCellIdentifier = "kTransactionCellIdentifier"
    private let disposeBag = DisposeBag()
    var addTransactionTapCallback: ((Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.attach(updater: CollectionViewUpdater(collectionView: collectionView))
        viewModel.refreshData()
    }
    
    // MARK: Initial setup
    
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        let cellNib = UINib(nibName: "TransactionCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: transactionCellIdentifier)
    }
    
    func addTransactionButtonTapped() {
        addTransactionTapCallback?()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.transactionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TransactionCell = collectionView.dequeueTypedCell(withIdentifier: transactionCellIdentifier, forIndexPath: indexPath)
        let cellViewModel = viewModel.transactionCellViewModel(atIndex: indexPath.row)
        cell.update(withViewModel: cellViewModel)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
}

extension TransactionsListViewController: BarButtonProvider {
    
    func barButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransactionButtonTapped))
    }
}
