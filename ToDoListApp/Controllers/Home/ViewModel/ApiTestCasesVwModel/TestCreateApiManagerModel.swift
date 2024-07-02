//
//  TestCreateApiManagerModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 02/07/24.
//

import Foundation

class TestCreateListApiManager: CreateListApiManagerProtocol {
    var shouldReturnError = false
    var createData: CreateUserModel?

    func CreateUserApi(todoTitle: String, userId: Int, completion: @escaping (Result<CreateUserModel, ErrorCondition>) -> Void) {
        if shouldReturnError {
            completion(.failure(.networkError(nil)))
        } else {
            guard let data = createData else {
                completion(.failure(.invalidResponse))
                return
            }
            completion(.success(data))
        }
    }
}
