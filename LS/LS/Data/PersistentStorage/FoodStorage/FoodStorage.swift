//
//  FoodStorage.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/24/22.
//

import Foundation

protocol FoodStorage {
    func getResponse(for request: FoodProductRequestDTO,
                     completion: @escaping (Result<FoodProductDTO?, CoreDataStorageError>) -> Void)
    func save(response: FoodProductDTO, for request: FoodProductRequestDTO)
}
