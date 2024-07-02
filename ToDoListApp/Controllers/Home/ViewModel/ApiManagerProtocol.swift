//
//  ApiManagerProtocol.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 02/07/24.
//

import Foundation

protocol GetListApiManagerProtocol {
    func getCategoriesApi(completion: @escaping (Result<UserListModel, ErrorCondition>) -> Void)
}

protocol CreateListApiManagerProtocol {
    func CreateUserApi(todoTitle: String, userId: Int, completion: @escaping (Result<CreateUserModel, ErrorCondition>) -> Void)
}
