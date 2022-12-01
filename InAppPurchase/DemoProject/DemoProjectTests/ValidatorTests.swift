//
//  ValidatorTests.swift
//  DemoProjectTests
//
//  Created by heerucan on 2022/11/30.
//

import XCTest
@testable import DemoProject

// Unit Test는 빨라야 한다. 소스 코드 기준으로 로직 테스트함
// 항상 같은 결과를 내야 한다. repeatable
class ValidatorTests: XCTestCase {
    
    var sut: Validator!
    // var sut: Validator() -> 이렇게 작성하면 사용된 인스턴스가 다음 테스트에 영향을 줄 수 있기 때문에 다른 테스트에 영향을 주지 않게끔. 고립시켜야 함

    // 인스턴스 생성하고
    override func setUpWithError() throws {
       sut = Validator()
    }

    // 인스턴스 해제
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
