//
//  ApiManager.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import Foundation
import Alamofire


class ApiManager: CreateListApiManagerProtocol, GetListApiManagerProtocol{
    
    static let shared = ApiManager()
    
    typealias apiHandler = (Result<UserListModel, ErrorCondition>)-> Void
    typealias addUserHandler = (Result<CreateUserModel,ErrorCondition>)-> Void
    typealias updateHandler = (Result<Any, ErrorCondition>)-> Void
    typealias deleteHandler = (Result<Any,ErrorCondition>)-> Void
    
    
    //MARK: Get List Api
    func getCategoriesApi(completion competion: @escaping apiHandler){
        guard let url = URL(string: "https://dummyjson.com/todos") else{
            competion(.failure(.invalidUrl))
            return
        }
        AF.request(url, method: .get, encoding: JSONEncoding.default).response { response in
            switch response.result{
            case.success(let categoriesList):
                guard let categoriesList = categoriesList else{
                    return
                }
                do{
                  let decoder = JSONDecoder()
                    let jsondata = try decoder.decode(UserListModel.self, from: categoriesList)
                    competion(.success(jsondata))
                }catch{
                    competion(.failure(.decodingError))
                }
                
            case.failure(let error):
                competion(.failure(.networkError(error)))
            }
        }
        
    }
 
    
    //MARK: Add Itmes API
    func CreateUserApi(todoTitle:String,userId:Int,completion:@escaping addUserHandler){
        guard let url = URL(string: "https://dummyjson.com/todos/add") else{
            completion(.failure(ErrorCondition.invalidUrl))
            return
        }

        let params = [
            "todo": todoTitle,
            "completed": true,
            "userId": userId,
        ]  as [String:Any]
        print("params",params)
        
        let hearders:HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url,method: .post, parameters: params,encoding: JSONEncoding.default, headers: hearders).response { response in
            switch response.result{
            case.success(let result):
                
                guard let data = result else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let postModel = try decoder.decode(CreateUserModel.self, from: data)

                    completion(.success(postModel))
                } catch {
                    completion(.failure(.decodingError))
                }
                catch{
                    completion(.failure(ErrorCondition.decodingError))
                }
                
            case.failure(let error):
                completion(.failure(ErrorCondition.networkError(error)))
            }
        }
    }
    
}


enum ErrorCondition: Error, Equatable {
    case invalidUrl
    case invalidResponse
    case decodingError
    case networkError(Error?)
    
    static func == (lhs: ErrorCondition, rhs: ErrorCondition) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrl, .invalidUrl),
             (.invalidResponse, .invalidResponse),
             (.decodingError, .decodingError):
            return true
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return (lhsError as NSError?)?.code == (rhsError as NSError?)?.code
        default:
            return false
        }
    }
}




