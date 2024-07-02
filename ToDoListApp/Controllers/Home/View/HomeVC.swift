//
//  HomeVC.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    let getlistModel = FetchItemListViewModel()
    let AddItemModel = AddDataViewModel()
    var listData:[Todo] = []
    var userIdList:[Int] = []
    var userID:[Int] = []
    var idCount:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    }
    
    
    func configuration(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "ListTableCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ListTableCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getListDataFromApi()
    }

    //MARK: List Api
    func getListDataFromApi(){
        DispatchQueue.main.async {
            Loader.showLoader()
        }
        getlistModel.getItemList()
        getlistModel.GetDataSuccess = { data in
            Loader.hideLoader()
            print(data.todos)
            let list = data.todos
            // Add Inside Database when Database will nill
            self.listData = DatabaseHelper.shared.getAddData()
            if self.listData.count <= 1 {
                DatabaseHelper.shared.saveApiListData(list: list)
                self.listData = list
            }
            
            self.tableView.reloadData()
        }
        
        getlistModel.FetDataFailure = { error in
            Loader.hideLoader()
           print(error)
        }
        
    }
   

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Create New List Data
    @IBAction func btnAddNewList(_ sender: Any) {
    userListContifguration(isAdd: true, index: 0)
    }
    
    
    //MARK: List Api
    func userListContifguration(isAdd:Bool, index:Int){
        let alertController = UIAlertController(title: isAdd ? "Add ":"Update" , message: isAdd ? "Add new Data":"Update selected Data" , preferredStyle: .alert)
        
        let save = UIAlertAction(title: "save", style: .default) { _ in
            if let title = alertController.textFields?.first?.text, let id = alertController.textFields?.last?.text{
              // Add New Item in list
                if isAdd{
                    DispatchQueue.main.async {
                        Loader.showLoader()
                    }
                    self.AddItemModel.createData(title: title, id: Int(id) ?? 0)
                    
                    self.AddItemModel.createSuccess = { data in
                        Loader.hideLoader()
                        var newData = Todo()
                        newData.todo = data.todo
                        newData.userId = data.userId
                        newData.completed = data.completed
                        newData.id = data.id ?? 0
                        print(data)
                        for (index, value) in self.userIdList.enumerated(){
                            if value == data.id{
                                self.idCount.append(value)
                            }
                        }
                        if self.idCount.count < 1{
                            
                            DatabaseHelper.shared.addNewListData(list: newData)
                            self.idCount.removeAll()
                            self.userIdList.removeAll()
                            self.getListDataFromApi()
                            
                        }else{
                            Loader.hideLoader()
                            let alert = UIAlertController(title: "Duplicate ID", message: "The ID already exists.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                        }
                      
                    }
                    self.AddItemModel.createFailure = { error in
                        Loader.hideLoader()
                        print(error)
                    }
                    
                  
                   
                }else{
                    // Update New Item in list
                    let newData = Todo()
                     newData.todo = title
                     newData.userId = self.listData[index].userId
                     newData.id = self.listData[index].id
                    let oldData = self.listData[index]
        DatabaseHelper.shared.updateData(oldData: oldData, newData: newData, index: index)
                self.tableView.reloadData()

                }
            }
        }
        
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { titleFields in
            titleFields.placeholder =  isAdd ? "Enter Title":self.listData[index].todo
        }
        
        // Fetch Enter textfield data
        alertController.addTextField { txtCompeled in
            txtCompeled.keyboardType = .numberPad
            txtCompeled.placeholder = isAdd ? "Enter ID": String(self.listData[index].userId)
            if !isAdd{
                txtCompeled.text = String(self.listData[index].userId)
                txtCompeled.isUserInteractionEnabled = false
            }else{
                txtCompeled.isUserInteractionEnabled = true
            }
            
        }
        
       
        alertController.addAction(save)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
    
}
//MARK: TableView Delegate and Datasource Method
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell", for: indexPath) as! ListTableCell
        // Display Data in list form
        cell.lblTitle.text =  listData[indexPath.row].todo
        let id = listData[indexPath.row].id
        self.userIdList.append(id)
        cell.lblDescription.text = String(id)
        cell.lblId.text = String(listData[indexPath.row].userId)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Edit Choosen Item in List
        let edit = UIContextualAction(style: .normal, title: "edit") { _, _, _ in
            
            self.userListContifguration(isAdd: false, index: indexPath.row)

        }
        
        edit.backgroundColor = .systemMint
        // Delete Choosen Item from List
        let cancel = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
           
            let id = self.listData[indexPath.row].id
            if let todoToDelete = DatabaseHelper.shared.getTodoById(id: id) {
                DatabaseHelper.shared.deleteToDo(todo: todoToDelete)
                self.listData.remove(at: indexPath.row)
                self.idCount.removeAll()
                self.userIdList.removeAll()
                self.getListDataFromApi()
            }
                                       
          }
                                         
        let swiftconfiguration = UISwipeActionsConfiguration(actions: [cancel, edit])
        return swiftconfiguration
        }
    
}


