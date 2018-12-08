//
//  TransactionCategoriesCollectionViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

class TransactionCategoriesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var presenter: TransactionCategoriesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCategories
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TransactionCategoryCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
        let item = presenter.categoryItem(at: indexPath)
        cell.update(with: item)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.3 - 8
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectItem(at: indexPath)
    }
}

extension TransactionCategoriesCollectionViewController: TransactionCategoriesCollectionUIProtocol {
    func reloadList() {
        collectionView?.reloadData()
    }
}
