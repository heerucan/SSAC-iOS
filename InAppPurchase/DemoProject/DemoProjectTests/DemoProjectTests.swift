//
//  DemoProjectTests.swift
//  DemoProjectTests
//
//  Created by heerucan on 2022/11/29.
//

import XCTest

@testable import DemoProject // @testable을 사용하면 접근제어가 높아도 바꿔주지 않아도 된다.
// internal -> test 시에는 알아서 public으로 바뀜

class DemoProjectTests: XCTestCase {
    
    // system under test의 줄임말 -> 테스트 하고자 하는 클래스를 정의할 때 사용
    var sut: LoginViewController! // 특정 뷰컨을 가져오려면 선언과 초기화를 해줘야 한다. 그래야 해당 뷰컨 내 메소드에 접근가능

    override func setUpWithError() throws {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        sut.loadViewIfNeeded() // 스토리보드 및 @IBOutlet 일 경우에 필요
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 이메일 유효성 테스트
    func testLoginViewController_validEmail_returnTrue() throws {
        // Given - 텍스트 객체 = Arrange
        sut.emailTextField.text = "ruhee@naver.com"
         
        // When - 텍스트 조건 및 행동 = Act
        let valid = sut.isValidEmail()
        
        // Then - 텍스트 결과 = Assert
        XCTAssertTrue(valid) // true면 테스트 성공
        
    }
    
    func testLoginViewController_inValidPassword_ReturnFalse() throws {
        
        sut.passwordTextField.text = "1234" // 4자리이기 때문에 false일 것임
        
        let valid = sut.isValidPassword()
        
        XCTAssertFalse(valid)
    }
    
    func testLoginViewController_emailTextField_ReturnNil() throws {
        
        sut.emailTextField = nil
        
        let value = sut.emailTextField
        
        XCTAssertNil(value)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
