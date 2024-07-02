//
//  DatabaseHelper.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import Foundation
import RealmSwift

class DatabaseHelper{
    
    static let shared = DatabaseHelper()
    
    private var realm = try! Realm()
    
    
    func getDatabaseUrl()-> URL?{
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveApiListData(list:[Todo]){
        try! realm.write({
            realm.add(list)
        })
    }
    
    
    func addNewListData(list:Todo){
        try! realm.write({
            realm.add(list)
        })
    }
    
    func updateData(oldData: Todo, newData: Todo, index: Int) {
          try! realm.write {
              oldData.todo = newData.todo
              oldData.userId = newData.userId
          }
      }
    
    func deleteToDo(todo: Todo) {
           try! realm.write({
               realm.delete(todo)
           })
       }
    
    func getAddData()-> [Todo]{
        return Array(realm.objects(Todo.self))
    }
    
    func getTodoById(id: Int) -> Todo? {
            return realm.objects(Todo.self).filter("id == %@", id).first
        }
}
