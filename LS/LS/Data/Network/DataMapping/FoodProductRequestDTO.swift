//
//  FoodProductRequestDTO.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/17/22.
//

import Foundation

struct FoodProductRequestDTO: Encodable {
    let foodId: Int

    private enum CodingKeys: String, CodingKey {
        case foodId = "foodid"
    }
}
