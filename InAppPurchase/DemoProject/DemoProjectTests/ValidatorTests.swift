//
//  ValidatorTests.swift
//  DemoProjectTests
//
//  Created by heerucan on 2022/11/30.
//

import XCTest
@testable import DemoProject

class ValidatorTests: XCTestCase {
    
    var sut: Validator!

    override func setUpWithError() throws {
       sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // ui와 logic이 분리되어서 코드가 작성되면 testable하다.
    // ui 관련된 거는 uitest에서 하면 되기 때문에!
    func testValidator_validEmail_returnTrue() throws {
       
        let user = User(email: "ruhee@naver.com", password: "1234", check: "1234")
        let valid = sut.isValidEmail(email: user.email)
        
        XCTAssertTrue(valid)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
