//
//  UIViewController+.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/08.
//

import UIKit

extension UIViewController {
    // okAction 이라는 매개변수 즉, () -> () 함수를 매개변수로 갖는,, 일급객체인 showAlert 함수는 클로저다.
    // 이 경우 해당 함수타입의 매개변수를 외부에서 쓴다는 것을 @escaping 키워드를 통해 명시해줘야 한다.
    func showAlert(title: String, message: String?, okTitle: String, okAction: @escaping () -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: okTitle, style: .default) { action in
            
            okAction()
            
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
