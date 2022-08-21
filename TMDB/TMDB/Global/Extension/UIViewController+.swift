//
//  UIViewController+.swift
//  TMDB
//
//  Created by heerucan on 2022/08/18.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case push
    }
    
    func transitionViewController<T: UIViewController>(storyboard sb: String,
                                                       viewController vc: T,
                                                       transitionStyle style: TransitionStyle,
                                                       completion: ((T) -> Void)? = nil) {
        
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T
        else { return }
        completion?(viewController)

        switch style {
        case .present:
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true)
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
