//
//  ViewController.swift
//  DemoProject
//
//  Created by heerucan on 2022/11/28.
//

import UIKit

import StoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var purchaseButton: UIButton!
    
    // 1. 인앱 상품 ID 정의
    // 배열인 이유는 상품이 여러개일 수 있기 때문에
    var productIdentifiers: Set<String> = ["com.ruheekim.DemoProject.removead"]
    
    // 2. 인앱 상품 정보
    var productArray = Array<SKProduct>()
    var product: SKProduct? // 구매할 상품
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProductData()
    }
    
    @IBAction func touchupPurchaseButton(_ sender: UIButton) {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self)
    }
    
    // 2. productIdentifier에 정의된 상품ID에 대한 정보 가져오기 및 사용자의 디바이스가 인앱결제가 가능한지 여부 확인
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            let request = SKProductsRequest(productIdentifiers: productIdentifiers)
            request.delegate = self
            request.start() //인앱 상품 조회
        } else {
            print("In App Purchase Not Enabled")
        }
    }
    
    // 영수증 검증
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
        // SandBox: “https://sandbox.itunes.apple.com/verifyReceipt”
        // iTunes Store : “https://buy.itunes.apple.com/verifyReceipt”
        
        //구매 영수증 정보
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        print(receiptString)
        //거래 내역(transaction)을 큐에서 제거 (안하면 중복으로 들어가거나 그런 문제 발생 가능)
        SKPaymentQueue.default().finishTransaction(transaction)
        
    }
}

extension ViewController: SKProductsRequestDelegate {
    // 응답에 대한 객체를 매개변수로 갖고, 여러개라서 배열을 갖고 있음.
    // 배열 count가 0이면 프로덕트 찾을 수 없음
    // 3. 인앱 상품 정보 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        let products = response.products
        
        if products.count > 0 {
            
            for i in products {
                productArray.append(i)
                product = i //옵션, 테이블 셀에서 구매하기 버튼 클릭 시 , 버튼 클릭 시
                
                print(i.localizedTitle, i.price, i.priceLocale, i.localizedDescription)
            }
            
        } else {
            print("No Product Found") // 계약 업데이트나 유료 계약 X / Capabilities X는 경우에 프로덕트 못 찾음
        }
    }
}

// 거래를 담당하는 옵저버

extension ViewController: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
                // 구매 성공 시
            case .purchased: //구매 승인 이후에 영수증 검증
                
                print("Transaction Approved. \(transaction.payment.productIdentifier)")
                receiptValidation(transaction: transaction, productIdentifier: transaction.payment.productIdentifier)
                
                // 구매 실패 시
            case .failed: //실패 토스트, transaction
                
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                
            default:
                break
            }
        }
    }
    
    // 구매 실패 시에는 아래의 코드가 동작해서 구매에 대한 내역을 제거해줌
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removedTransactions")
    }
}
