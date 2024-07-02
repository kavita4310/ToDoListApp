//
//  Alert.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 02/07/24.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(message:String){
        
        let alert = UIAlertController(
            title: "Alert",
            message: message,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: "ok",
            style: .default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true)
       
        
    }
}
