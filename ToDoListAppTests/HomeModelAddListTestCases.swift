//
//  HomeModelAddListTestCases.swift
//  ToDoListAppTests
//
//  Created by kavita chauhan on 02/07/24.
//

import XCTest
@testable import ToDoListApp

final class HomeModelAddListTestCases: XCTestCase {
    
    var viewModel: AddDataViewModel?
       var addlistApiManager: TestCreateListApiManager?

       override func setUpWithError() throws {
           addlistApiManager = TestCreateListApiManager()
           viewModel = AddDataViewModel(apiManager: addlistApiManager!)
       }

       override func tearDownWithError() throws {
           viewModel = nil
           addlistApiManager = nil
       }
    // function for testing sucess case
       func testCreateDataSuccess() {
           let expectation = self.expectation(description: "Success")
           let createUserModel = CreateUserModel(todo: "Test Todo", completed: true, userId: 1)
           addlistApiManager?.createData = createUserModel
           addlistApiManager?.shouldReturnError = false

           viewModel?.createSuccess = { data in
               XCTAssertEqual(data.todo, "Test Todo")
               XCTAssertEqual(data.completed, true)
               XCTAssertEqual(data.userId, 1)
               expectation.fulfill()
           }

           viewModel?.createFailure = { error in
               XCTFail("Expected success but got failure with error: \(error)")
           }

           viewModel?.createData(title: "Test Todo", id: 1)
           waitForExpectations(timeout: 1, handler: nil)
       }

    
    
    // function for Failure case
       func testCreateDataFailure() {
           let expectation = self.expectation(description: "Failure")
           addlistApiManager?.shouldReturnError = true

           viewModel?.createSuccess = { data in
               XCTFail("Expected failure but got success with data: \(data)")
           }

           viewModel?.createFailure = { error in
               XCTAssertEqual(error, .networkError(nil))
               expectation.fulfill()
           }

           viewModel?.createData(title: "Test Todo", id: 1)
           waitForExpectations(timeout: 1, handler: nil)
       }
}
