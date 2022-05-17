//
//  FoodProductResponseDTO.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/17/22.
//

import Foundation

struct FoodProductResponseDTO: Decodable {
    let meta: MetaDTO
    let response: FoodProductDTO
}

struct MetaDTO: Decodable {
    let code: Int
}

struct FoodProductDTO: Decodable {
    let title: String
    let pcsText: String
    let carbs: Double
    let fiber: Double
    let potassium: Double
    let sodium: Double
    let calories: Double
    let fat: Double
    let sugar: Double
    let gramsPerServing: Double
    let cholesterol: Double
    let protein: Double
    let unsaturatedFat: Double
    let saturatedFat: Double

    private enum CodingKeys: String, CodingKey {
        case title
        case pcsText = "pcstext"
        case carbs
        case fiber
        case potassium
        case sodium
        case calories
        case fat
        case sugar
        case gramsPerServing = "gramsperserving"
        case cholesterol
        case protein
        case unsaturatedFat = "unsaturatedfat"
        case saturatedFat = "saturatedfat"
    }
}
