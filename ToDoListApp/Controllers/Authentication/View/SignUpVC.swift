//
//  SignUpVC.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import UIKit

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
   var signUpModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func btnRegister(_ sender: Any) {
        
        let type =  signUpModel.checkValidatioin(txtEmail.text, password: txtPassword.text)
         if type.rawValue == ValidationType.sucess.rawValue{
             
             UserLocalStore.shared.emailId = txtEmail.text ?? ""
             UserLocalStore.shared.password = txtPassword.text ?? ""
             
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
             self.navigationController?.pushViewController(vc, animated: true)
         }else{
             showAlert(message: type.rawValue)
         }
      
     }
    
    
    //MARK: Navigation
    
    @IBAction func btnLogin(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
