//
//  HistoryEntity+Mapping.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import Foundation

// MARK: - Domain

extension HistoryEntity {
    func toDTO() -> FoodHistoryDTO {
        FoodHistoryDTO(shakeDate: shakeDate,
                       foodProduct: foodEntity?.toDTO())
    }
}
