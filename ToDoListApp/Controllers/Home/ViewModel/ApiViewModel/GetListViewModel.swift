//
//  GetListViewModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import Foundation


class FetchItemListViewModel {
    var GetDataSuccess: ((UserListModel) -> Void)?
    var FetDataFailure: ((ErrorCondition) -> Void)?
    private let apiManager: GetListApiManagerProtocol

    init(apiManager: GetListApiManagerProtocol = ApiManager.shared) {
        self.apiManager = apiManager
    }

    func getItemList() {
        apiManager.getCategoriesApi { response in
            switch response {
            case .success(let data):
                self.GetDataSuccess?(data)
            case .failure(let error):
                self.FetDataFailure?(error)
            }
        }
    }
}
