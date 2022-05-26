//
//  HistoryViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import Foundation
import UIKit

final class HistoryViewModel {

    private(set) var itemsCount: Observable<Int> = Observable(0)
    private(set) var items: Observable<[HistoryItemViewModel]?> = Observable(nil)

    private let useCase: HistoryUseCase

    private var historyItem: HistoryItem? {
        didSet {
            triggerUpdate()
        }
    }

    init(useCase: HistoryUseCase) {
        self.useCase = useCase
    }

    func viewDidLoad() {
        useCase.getHistory { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let historyItem):
                self.historyItem = historyItem

            case .failure(let error):
                print(error)
            }
        }
    }

    func historyItemViewModel(at indexPath: IndexPath) -> HistoryItemViewModel? {
        guard historyItem != nil,
              items.value?.count ?? 0 > indexPath.row
        else {
            return nil
        }

        return items.value?[indexPath.row]
    }
}

private extension HistoryViewModel {

    func triggerUpdate() {

        items.value = historyItem?.items.compactMap { HistoryItemViewModel(food: $0) }
        itemsCount.value = items.value?.count ?? 0
    }
}
