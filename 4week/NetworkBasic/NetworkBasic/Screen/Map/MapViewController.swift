//
//  MapViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/29.
//

import UIKit

final class MapViewController: UIViewController {
    
    // MARK: - Property
    
    // Notification 1. 로컬 노티피케이션을 담당하는 객체 가져오기
    let notificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - @IBAction
    
    @IBAction func downloadButton(_ sender: Any) {
        let url = "https://apod.nasa.gov/apod/image/2208/M13_final2_sinfirma.jpg"
        print("1", Thread.isMainThread)
        
        DispatchQueue.global().async { // 동시에 여러 작업이 가능하게 해줘!
            print("2", Thread.isMainThread)
            let data = try! Data(contentsOf: URL(string: url)!)
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                print("3", Thread.isMainThread)
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        requestAuthorization()
        
        // Custom Font 가 잘 들어왔는지 체크
//        for family in UIFont.familyNames {
//            print("========\(family)========")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
    }
    
    // MARK: - Custom Method
    
    // Notification 2. 권한 요청
    func requestAuthorization() {
        
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            
            if success {
                self.sendNotification()
            }
        }
    }
    
    // Notification 3. 권한 허용한 사용자에게 알림 요청 - 언제? 어떤 콘텐츠?
    // iOS 시스템에게 알림 담당, 알림 등록
    
    
    /*
     
     - 권한 허용을 해야만 알림이 오고
     - 권한 허용 문구 시스템적으로 최초 한 번만 뜬다
     - 허용 안된 경우 애플 설정으로 직접 유도하는 코드를 구성해야 한다
     - 로컬 알림에서는 60초 이상 반복 가능 / 개수 제한 64개
     
     
     1. 뱃지 제거
     2. 노티 제거
     3. 포그라운드 수신?
     
     + a
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     - 포그라운드 수신, 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 받고 싶다면?
     - iOS 15
     */
    
    func sendNotification() {
        // 클래스라서 let으로 선언했지만 내부의 프로퍼티를 변경할 수 있다.
        // 어떤 콘텐츠를 보낼 것인가?
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "루희"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))"
        notificationContent.body = "잠자라"
        notificationContent.badge = 40
        
        // 언제 보낼 것인가? 1. 시간 간격, 2. 캘린더 3. 위치에 따라 설정
        
        // * 시간 트리거
        // 시간 간격일 때는 60초 이상일 때야 가능 || 5초 간격이려면 반복이 아니면 된다.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        
        // * 캘린더 트리거
        // 구조체라서 let으로 써주면 오류가 발생한다.
        var dateComponents = DateComponents()
        dateComponents.minute = 11
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 알림 요청
        // identifier :
        // 만약 알림 관리할 필요 X : 알림 클릭하면 앱 켜주는 정도
        // 만약 알림 관리할 필요 o : +1, 고유 이름, 규칙 등
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
}
