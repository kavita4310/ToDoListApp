//
//  LoginModelTestCases.swift
//  ToDoListAppTests
//
//  Created by kavita chauhan on 02/07/24.
//

import XCTest
@testable import ToDoListApp

final class LoginModelTestCases: XCTestCase {
    
    var loginModel: LoginViewModel?

       override func setUpWithError() throws {
           loginModel = LoginViewModel()
       }

       override func tearDownWithError() throws {
           loginModel = nil
       }

       func testEmptyEmail() {
           guard let loginModel else {
               XCTFail("Login model is nil")
               return
           }

           let type = loginModel.checkValidatioin("", password: "password")
           XCTAssertEqual(type, .emptyEmail, "Expected .emptyEmail but got \(type)")
       }

       func testInvalidEmail() {
           guard let loginModel else {
               XCTFail("Login model is nil")
               return
           }

           let type = loginModel.checkValidatioin("invalid-email", password: "password")
           XCTAssertEqual(type, .invalidEmail, "Expected .invalidEmail but got \(type)")
       }

       func testEmptyPassword() {
           guard let loginModel else {
               XCTFail("Model is nil")
               return
           }

           let type = loginModel.checkValidatioin("kavita@gmail.com", password: "")
           XCTAssertEqual(type, .emptyPassword, "Expected .emptyPassword but got \(type)")
       }

       func testPasswordCount() {
           guard let loginModel else {
               XCTFail("Model is nil")
               return
           }

           let type = loginModel.checkValidatioin("kavita@gmail.com", password: "1234567")
           XCTAssertEqual(type, .passwordCount, "Expected .passwordCount but got \(type)")
       }

       func testValidEmail() {
           guard let loginModel else {
               XCTFail("Login model is nil")
               return
           }

           let type = loginModel.checkValidatioin("kavita@gmail.com", password: "12345678")
           XCTAssertEqual(type, .sucess, "Expected .sucess but got \(type)")
       }
    
    
}
