//
//  SceneDelegate.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    // 시작하는 화면을 연결하기 전에 여기서 통제가능
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // true이면 ViewController를 띄우고, false면 기존 유저니까 홈으로 이동~
//        UserDefaults.standard.set(false, forKey: "First") // > 이건 sceneDelegate에 있으면 안됨
        // 왜냐하면 앱이 시작될 때마다 값이
        
//        guard let scene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: scene)
//
//        if UserDefaults.standard.bool(forKey: "First") {
//            let sb = UIStoryboard(name: "Trend", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "MyViewController") as! MyViewController
//
//            window?.rootViewController = UINavigationController(rootViewController: vc)
//        } else {
//
//            let sb = UIStoryboard(name: "Trend", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
//
//            window?.rootViewController = UINavigationController(rootViewController: vc)
//        }
//
//        window?.makeKeyAndVisible() // window에 실제로 이 rootViewController를 보여주는 역할

        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

