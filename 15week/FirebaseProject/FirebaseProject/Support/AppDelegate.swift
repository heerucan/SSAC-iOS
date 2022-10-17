//
//  AppDelegate.swift
//  FirebaseProject
//
//  Created by heerucan on 2022/10/11.
//

import UIKit

import FirebaseCore
import FirebaseMessaging
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        aboutRealmMigration()
        
        UIViewController.swizzleMethod()
        
        FirebaseApp.configure()
        
        // 알림 시스템에 앱 등록 - 권한 요청
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // 메시지 대리자 설정
        Messaging.messaging().delegate = self
        
        // 현재 등록된 토큰 가져오기 -> 유저가 탈퇴할 때 해당 코드가 필요하지만, 앱이 재시작될 때마다 해당 부분이 필요하지는 않다.
//                Messaging.messaging().token { token, error in
//                  if let error = error {
//                    print("Error fetching FCM registration token: \(error)")
//                  } else if let token = token {
//                    print("FCM registration token: \(token)")
//                  }
//                }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

// MARK: - Realm Migration

extension AppDelegate {
    
    func aboutRealmMigration() {
        // deleteRealmIfMigrationNeeded : 마이그레이션이 필요한 경우 기존 렘을 삭제한다는 뜻
        // Realm Browser 닫고 다시 열기
        // let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        
        // 모든 버전에 대한 대응이 여기서 들어간다.
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 { // content 컬럼을 추가
                
            }
            
            if oldSchemaVersion < 2 { // content 컬럼을 삭제
                
            }
            
            if oldSchemaVersion < 3 { // 이 지점에서는 프로퍼티명을 바꿧음 importance -> favorite
                migration.renameProperty(onType: Todo.className(), from: "importance", to: "favorite")
            }
            
            if oldSchemaVersion < 4 {
                // 새로운 컬럼이 추가되었고, 여기서는 기존 컬럼들의 내용을 하나로 합쳐서 새 컬럼에 내용을 넣어줄 거다.
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    // 컬럼 단순 추가/삭제인 경우에는 별도 코드 필요X -> 1/2에 해당됨
                    new["userDescription"] = "안녕하세요 \(old["title"]!)의 중요도는 \(old["favorite"]!)입니다"
                    
                    /* new[“title”]로 해도 상관은 없나요?
                     -> 기존에 있는 컬럼이기에 초기값을 넣어주는 게 아님
                     newObject가 아니라 oldObject에 해당하니까.
                     */
                }
            }
            
            if oldSchemaVersion < 5 { // Int 타입의 새 컬럼을 추가
                migration.enumerateObjects(ofType: Todo.className()) { _, newObject in
                    guard let new = newObject else { return }
                    new["count"] = 100
                }
            }
            
            if oldSchemaVersion < 6 { // 타입이 변경되었을 경우 Int -> Double
                // object의 컬럼을 건드는 것이기 때문에 메소드는 똑같음
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["favorite"] = old["favorite"]
                    
                    // Int는 어떻게 Bool값으로 바꾸지? -> 조건문으로 처리가능함
                    
                    /* 만약 favorite이 Int?인 경우에는? : Double로 형변환이 필요
                     -> new["favorite"] = old["favorite"] ?? 1.0
                     -> 이런식으로 닐 병합연산자로 Default 값을 대응을 해줘야 함
                     -> 근데 기존과 새로 바꿀 컬럼의 타입이 둘 다 Int? Double?라면 대응할 필요는 없다.
                    */
                }
            }
            
            Realm.Configuration.defaultConfiguration = config
        }
    }
}

// MARK: - Push Notification

// 애플 내장 기능
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 재구성 사용 중지됨: APNs 토큰과 등록 토큰 매핑
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // foreground에서 알림 수신: 로컬/푸시 동일
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // 특정화면에서는 포그라운드 푸시를 제한할 수 있다
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        print("😊", viewController)
        
        // SettingViewController에서는 푸시를 제한한다.
        if viewController is SettingViewController {
            completionHandler([])
        } else {
            completionHandler([.badge, .sound, .banner, .list])
            
        }
    }
    
    // 푸시 클릭
    // 유저가 푸시를 클릭했을 때에만 수신 확인 가능
    
    // 특정 푸시를 클릭하면 특정 상세 화면으로 화면 전환 >
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("사용자가 푸시를 클릭했습니다.")
        print(response.notification.request.content.title)
        print(response.notification.request.content.userInfo)
        print(response.notification.request.content.body)
        
        let userInfo = response.notification.request.content.userInfo
        
        if userInfo[AnyHashable("sesac")] as? String == "project" {
            print("홈 화면으로 넘긴다.")
        } else {
            print("그냥 냅둔다.")
        }
        
        
        // topViewController는 우리가 만든 것
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        print("😊", viewController)
        
        // 클래스가 ViewController라면 그냥 무조건 SettingViewController로 넘겨주는 것임
        if viewController is ViewController {
            viewController.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
        
        if viewController is ProfileViewController {
            viewController.dismiss(animated: true)
        }
        
        if viewController is SettingViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
}

// 파베 기능
extension AppDelegate: MessagingDelegate {
    
    // 토큰 갱신 모니터링: 토큰 정보가 언제 바뀔까?
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
