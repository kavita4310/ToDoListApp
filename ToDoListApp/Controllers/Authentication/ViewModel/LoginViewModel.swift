//
//  LoginViewModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 02/07/24.
//

import Foundation

final class LoginViewModel {
    func checkValidatioin(_ email: String?, password: String?) -> ValidationType {
        guard let email, !email.isEmpty else {
            return .emptyEmail
        }

        guard isValidEmail(email) else {
            return .invalidEmail
        }

        guard let password, !password.isEmpty else {
            return .emptyPassword
        }

        guard password.count > 7 else {
            return .eightDigitPasswordCount
        }

        return .sucess
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
