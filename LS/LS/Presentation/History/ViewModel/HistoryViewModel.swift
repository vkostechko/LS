//
//  HistoryViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import Foundation

final class HistoryViewModel {

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
}

private extension HistoryViewModel {

    func triggerUpdate() {

    }
}
