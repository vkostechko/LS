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
                let requestEntity = try self.fetchFoodEntity(for: request, in: context)

                completion(.success(requestEntity?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(response: FoodProductDTO, for request: FoodProductRequestDTO, completion: @escaping () -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteEntity(for: request, in: context)
                let entity = response.toEntity(in: context)
                entity.foodId = request.foodId
                try context.save()
                completion()
            } catch {
                print(error)
                completion()
            }
        }
    }

    func add(response: FoodProductDTO, toHostoryFor request: FoodProductRequestDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let historyFetchRequest = HistoryEntity.fetchRequest()
                historyFetchRequest.predicate = NSPredicate(format: "%K == %d", #keyPath(HistoryEntity.foodEntity.foodId), request.foodId)
                historyFetchRequest.fetchLimit = 1

                var historyEntity = try context.fetch(historyFetchRequest).first
                if historyEntity == nil {
                    historyEntity = HistoryEntity(context: context)
                    historyEntity?.foodEntity = try self.fetchFoodEntity(for: request, in: context)
                }

                historyEntity?.shakeDate = Date()

                try context.save()

            } catch {
                print(error)
            }
        }
    }

    func getHistory(completion: @escaping (Result<FoodHistoryResponseDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = HistoryEntity.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: #keyPath(HistoryEntity.shakeDate),
                                                      ascending: true)
                fetchRequest.sortDescriptors = [sortDescriptor]

                let items = try context.fetch(fetchRequest)
                let response =  FoodHistoryResponseDTO(items: items.map { $0.toDTO() })
                completion(.success(response))

            } catch {
                print(error)
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
}

// MARK: - Private

private extension FoodStorageImpl {

    func fetchRequest(for request: FoodProductRequestDTO) -> NSFetchRequest<FoodEntity> {
        let fetchRequest = FoodEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %d", #keyPath(FoodEntity.foodId), request.foodId)
        return fetchRequest
    }

    func deleteEntity(for request: FoodProductRequestDTO, in context: NSManagedObjectContext) {
        do {
            if let result = try self.fetchFoodEntity(for: request, in: context) {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }

    func fetchFoodEntity(for request: FoodProductRequestDTO, in context: NSManagedObjectContext) throws -> FoodEntity? {
        let fetchRequest = fetchRequest(for: request)
        fetchRequest.fetchLimit = 1
        return try context.fetch(fetchRequest).first
    }
}
