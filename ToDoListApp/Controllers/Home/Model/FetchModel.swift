//
//  FetchModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import Foundation
import RealmSwift

// MARK: - UserListModel
class UserListModel: Codable {
    let todos: [Todo]
    let total: Int
    let skip: Int
    let limit: Int
    
    init(todos: [Todo], total: Int, skip: Int, limit: Int) {
        self.todos = todos
        self.total = total
        self.skip = skip
        self.limit = limit
    }
}

// MARK: - Todo
class Todo: Object, Codable {
    @Persisted var id: Int
    @Persisted var todo: String
    @Persisted var completed: Bool
    @Persisted var userId: Int

    convenience init(id: Int, todo: String, completed: Bool, userId: Int) {
        self.init()
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
}
