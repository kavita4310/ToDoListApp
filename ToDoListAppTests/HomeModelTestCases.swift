//
//  HomeModelTestCases.swift
//  ToDoListAppTests
//
//  Created by kavita chauhan on 02/07/24.
//

import XCTest
@testable import ToDoListApp

final class HomeModelTestCases: XCTestCase {
    
    // object of Model
    var getList: FetchItemListViewModel?
      var testApiManager: TestGetApiManager?
      
      override func setUpWithError() throws {
          testApiManager = TestGetApiManager()
          getList = FetchItemListViewModel(apiManager: testApiManager!)
      }

      override func tearDownWithError() throws {
          getList = nil
          testApiManager = nil
      }

    // function for testing sucess case
      func testGetItemListSuccess() {
          let expectation = self.expectation(description: "Success")
          testApiManager?.shouldReturnError = false
          
          getList?.GetDataSuccess = { data in
              XCTAssertEqual(data.todos.count, 2)
//              XCTAssertEqual(data.todos[0].todo, "Mock todo 1")
              expectation.fulfill()
          }
          
          getList?.FetDataFailure = { error in
              XCTFail("Expected success but got failure with error: \(error)")
          }
          
          getList?.getItemList()
          waitForExpectations(timeout: 1, handler: nil)
      }
    
    
    
    
    // function for Failure case
      func testGetItemListFailure() {
          let expectation = self.expectation(description: "Failure")
          testApiManager?.shouldReturnError = true
          
          getList?.GetDataSuccess = { data in
              XCTFail("Expected failure but got success with data: \(data)")
          }
          
          getList?.FetDataFailure = { error in
              XCTAssertEqual(error, .networkError(nil))
              expectation.fulfill()
          }
          
          getList?.getItemList()
          waitForExpectations(timeout: 1, handler: nil)
      }
}
