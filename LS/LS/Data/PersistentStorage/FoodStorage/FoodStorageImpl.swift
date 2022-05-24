//
//  FoodStorageImpl.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/24/22.
//

import Foundation
import CoreData

final public class FoodStorageImpl {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

// MARK: - FoodStorage

extension FoodStorageImpl: FoodStorage {

    func getResponse(for request: FoodProductRequestDTO,
                     completion: @escaping (Result<FoodProductDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: request)
                let requestEntity = try context.fetch(fetchRequest).first

                completion(.success(requestEntity?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(response: FoodProductDTO, for request: FoodProductRequestDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteEntity(for: request, in: context)
                let entity = response.toEntity(in: context)
                entity.foodId = request.foodId
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Private

extension FoodStorageImpl {

    func fetchRequest(for request: FoodProductRequestDTO) -> NSFetchRequest<FoodEntity> {
        let fetchRequest = FoodEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %d", #keyPath(FoodEntity.foodId), request.foodId)
        return fetchRequest
    }

    func deleteEntity(for request: FoodProductRequestDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: request)
        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}
