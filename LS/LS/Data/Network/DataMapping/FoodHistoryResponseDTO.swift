//
//  FoodHistoryResponseDTO.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import Foundation

struct FoodHistoryResponseDTO {
    let items: [FoodHistoryDTO]
}

struct FoodHistoryDTO {
    let shakeDate: Date?
    let foodProduct: FoodProductDTO?
}

extension FoodHistoryResponseDTO {

    func toDomain() -> HistoryItem {
        HistoryItem(items: items.compactMap { $0.toDomain() })
    }
}

extension FoodHistoryDTO {
    func toDomain() -> FoodProduct? {
        foodProduct?.toDomain()
    }
}
