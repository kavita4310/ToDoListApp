//
//  CreateModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import Foundation

class CreateUserModel: Codable{
    let id: Int?
    let todo: String
    let completed: Bool
    let userId: Int
    
    init(id: Int = 0, todo: String, completed: Bool, userId: Int) {
     
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
}

