//
//  SignInVC.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 01/07/24.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let loginModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        txtEmail.text = ""
        txtPassword.text = ""
    }
    
    
    //MARK: Navigation Home Screen
    @IBAction func btnLogin(_ sender: Any) {
        
       let type =  loginModel.checkValidatioin(txtEmail.text, password: txtPassword.text)
        if type.rawValue == ValidationType.sucess.rawValue{
            if UserLocalStore.shared.emailId != txtEmail.text!{
              showAlert(message: "Email-Id not exist")
            }else if UserLocalStore.shared.password != txtPassword.text!{
                showAlert(message: "Password not exist")
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
            }

        }else{
            showAlert(message: type.rawValue)
        }
     
    }
    
    
    //MARK: Navigation to SignUp 
    @IBAction func btnSignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
