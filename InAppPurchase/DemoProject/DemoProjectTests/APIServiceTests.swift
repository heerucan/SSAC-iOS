//
//  APIServiceTests.swift
//  DemoProjectTests
//
//  Created by heerucan on 2022/12/01.
//

import XCTest
@testable import DemoProject

class APIServiceTests: XCTestCase {

    var sut: APIService!
    
    override func setUpWithError() throws {
        sut = APIService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() throws {
        print("testExample Start")
        
        sut.number = 100
        
        // completion을 타지 않아서
        // 비동기 부분에서 네트워크 통신에 대한 답이 오기를 기다려주지 않고 테스트를 시작하고 마침
        sut.callRequest { value in
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
            print("callRequest")
        }
        print("testExample End")
    }
    
    // 비동기 테스트에서 유의할 것 : expectation, fulfill, wait
    
    /* 🔅 Test Double이란? 왜 mock data가 필요한가!
     네트워크 : 아이폰 네트워크 응답X or API 서버 점검, 동시접속사가 너무 많아서 API 지연
     효율적/속도/같은 조건에서 테스트를 해야 하는데 그 조건이 깨짐.
     테스트 대상이 외부 격리X
     
     -> 이걸 어케 개선하지? : 예측 불가능한 상황을 만들면 안됨
     ** 외부 영향을 받는 테스트는 좋지 못한 테스트임!
     
     => 실제 네트워크 동작이 되는 것처럼 보이게 별개의 객체를 만듦!
     즉, 실제로 통신하지 않는데 네트워크 통신처럼 동작함
     
     => 이걸 테스트 더블 (Test Double) 이라고 함
        : 테스트 코드랑 상호작용 할 수 있는 가짜 객체 생성 (like 스턴트맨)
        ex. dummy, mock, fake data, stub, spy... 같은 데이터로 이야기 함
     
     */
    func test_APILottoResponse_AsyncCover() throws {
        
        print("testExample Start")
        
        // 어떤 값을 예견할 건지 설명 씀 -> 로또 넘버 응답이 올 때까지 기다림
        let promise = expectation(description: "waiting lotto number, completion handler invoked")
        
        sut.number = 33
        
        sut.callRequest { value in
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
            print("call request")
            promise.fulfill() // expectation으로 정의된 테스트 조건을 충족!
        }
        
        print("testExample End")
        
        // 어떤 상황(for : 배열 부분)에 대해 몇 초 동안 기다릴지(timeout)
        // promise가 실행되고 5초 기다리면. -> 네트워크 통신 응답이 그 사이에 오는 것
        wait(for: [promise], timeout: 5)
        
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
