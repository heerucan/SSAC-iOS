//
//  DemoProjectUITests.swift
//  DemoProjectUITests
//
//  Created by heerucan on 2022/11/29.
//

import XCTest

class DemoProjectUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false // 실패가 뜨면 앱을 중지할 것이냐?에 대한 부분

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication() // 앱의 실행과 종료
        app.launch()
        
        app.textFields["emailTextField"].tap()
        app.textFields["emailTextField"].typeText("@naver.com")

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoginExample() throws {
        let app = XCUIApplication() // 앱의 실행과 종료
        app.launch()
        
        app.textFields["emailTextField"].tap()
        app.textFields["emailTextField"].typeText("ruhee@naver.com")
        
        // XCTAssertEqual(5, 9) // 두 숫자가 같다고 해주는 것 -> 다르니까 실패
        
        app.textFields["passwordTextField"].tap()
        app.textFields["passwordTextField"].typeText("123456")
        
        app.textFields["checkTextField"].tap()
        app.textFields["checkTextField"].typeText("루희짱")
        
        app.staticTexts["로그인"].tap()
        
        let label = app.staticTexts.element(matching: .any, identifier: "descriptionLabel").label
        XCTAssertEqual(label, "로그인 버튼을 눌렀습니다.")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
