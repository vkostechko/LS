//
//  HistoryViewController.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: HistoryViewModel!

    let flowLayoutDelegate = PagingFlowLayout(cellWitdhPercentage: 0.8, distanceBetweenCells: 16.0)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bind(to: viewModel)

        viewModel.viewDidLoad()
    }

    // MARK: - Private

    private func prepareUI() {
        collectionView.register(UINib(nibName: String(describing: HistoryItemCell.self), bundle: nil),
                                forCellWithReuseIdentifier: HistoryItemCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = flowLayoutDelegate
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
    }

    private func bind(to viewModel: HistoryViewModel) {
        viewModel.itemsCount.observe(on: self) { [weak self] count in
            self?.reloadData()
        }
    }
}

// MARK: - Data

private extension HistoryViewController {

    func reloadData() {
        collectionView.reloadData()
    }
 }

// MARK: - UICollectionViewDataSourse

extension HistoryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount.value
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let reuseIdentifier = HistoryItemCell.reuseIdentifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? HistoryItemCell
        else {
            fatalError("Can not dequeue cell with id: \(reuseIdentifier)")
        }

        cell.viewModel = viewModel.historyItemViewModel(at: indexPath)

        return cell
    }
}
