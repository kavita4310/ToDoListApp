//
//  CreateListViewModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import Foundation

class AddDataViewModel {
    var createSuccess: ((CreateUserModel) -> Void)?
    var createFailure: ((ErrorCondition) -> Void)?  // Change type to ErrorCondition
    
    private let apiManager: CreateListApiManagerProtocol

    init(apiManager: CreateListApiManagerProtocol = ApiManager.shared) {
        self.apiManager = apiManager
    }

    func createData(title: String, id: Int) {
        apiManager.CreateUserApi(todoTitle: title, userId: id) { response in  // Use injected apiManager
            switch response {
            case .success(let data):
                self.createSuccess?(data)
            case .failure(let error):
                self.createFailure?(error)
            }
        }
    }
}
