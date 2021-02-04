//
//  GitHubApplicationTests.swift
//  GitHubApplicationTests
//
//  Created by PRANOTI KULKARNI on 2/3/21.
//

import XCTest
@testable import GitHubApplication

class GitHubApplicationTests: XCTestCase {
    
    var sut: URLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }

    func testAPIWorking()
      {
          
          let url = URL(string: "https://api.github.com/repos/eficode/weatherapp/commits")
          // 1
          let promise = expectation(description: "Status code: 200")
          
          // when
          let dataTask = sut.dataTask(with: url!) { data, response, error in
              // then
              if let error = error {
                  XCTFail("Error: \(error.localizedDescription)")
                  return
              } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                  if statusCode == 200 {
                      // 2
                      promise.fulfill()
                  } else {
                      XCTFail("Status code: \(statusCode)")
                  }
              }
          }
          dataTask.resume()
          // 3
          wait(for: [promise], timeout: 5)
      }

}
