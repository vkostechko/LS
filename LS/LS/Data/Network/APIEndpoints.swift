//
//  APIEndpoints.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/17/22.
//

import Foundation

struct APIEndpoints {
    static func getFoodProduct(with foodProductDTO: FoodProductRequestDTO) -> Endpoint<FoodProductResponseDTO> {
        Endpoint(path: "v2/foodipedia/codetest",
                 method: .get,
                 queryParametersEncodable: foodProductDTO)
    }
}
