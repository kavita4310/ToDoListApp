//
//  TestApiManagerModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 02/07/24.
//

import Foundation

class TestGetApiManager: GetListApiManagerProtocol {
    var shouldReturnError = false

    func getCategoriesApi(completion: @escaping (Result<UserListModel, ErrorCondition>) -> Void) {
        if shouldReturnError {
            completion(.failure(.networkError(nil)))
        } else {
            // Populate with mock data
            let listTodos = [
                Todo(id: 1, todo: " todo 1", completed: false, userId: 1),
                Todo(id: 2, todo: " todo 2", completed: true, userId: 2)
            ]
            let list = UserListModel(todos: listTodos, total: 2, skip: 0, limit: 2)
            completion(.success(list))
        }
    }
}

