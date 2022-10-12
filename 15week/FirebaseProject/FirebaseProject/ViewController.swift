//
//  ViewController.swift
//  FirebaseProject
//
//  Created by heerucan on 2022/10/11.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController ViewWillApper")
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        present(ProfileViewController(), animated: true, completion: nil)
    }
    @IBAction func settingButtonClicked(_ sender: Any) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    @IBAction func crashClicked(_ sender: Any) {
        
    }
}


final class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileViewController ViewWillApper")
    }
}

final class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SettingViewController ViewWillApper")
    }
}

extension UIViewController {
    
    // 연산 프로퍼티를 호출하면 아래 메소드가 호출되어 동작
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    // 최상위 뷰컨트롤러를 판단해주는 메소드
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        
        // 1. 타입캐스팅이 된다면 탭바 컨트롤러에서 선택된 뷰컨을 가져오면 된다.
        if let tabBarController = currentViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
            
            // 2. 네비뷰컨으로 타입캐스팅이 된다면 현재 보고 있는 뷰컨을 가져오면 된다.
        } else if let navigationController = currentViewController as? UINavigationController,
                  let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
            
            // 3. 위와 무관한 일반 뷰컨
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
            
        } else {
            return currentViewController
        }
    }
}

extension UIViewController {
    
    static func swizzleMethod() {
        let origin = #selector(viewWillAppear) // 원래 메소드
        let change = #selector(changeViewWillAppear) // 바꿔주려는 메소드
        
        // UIViewController의 origin이라는 메소드를 가지고 오겠다.
        // 너 UIViewController의 인스턴스를 만들었을 때 거기에 viewWillAppear/changeViewWillAppear가 있는지 확인하겠다.
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin),
              let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
                  print("함수를 찾을 수 없거나 오류 발생")
                  return
              }
        
        // 메소드를 바꿔주기
        method_exchangeImplementations(originMethod, changeMethod)
    }
    
    // 바꿔주려는 메소드의 실제 작동되는 부분
    @objc func changeViewWillAppear() {
        print("Change ViewWillAppear SUCCEED🧡")
    }
}
