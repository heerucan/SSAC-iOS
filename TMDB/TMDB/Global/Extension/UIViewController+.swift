//
//  UIViewController+.swift
//  TMDB
//
//  Created by heerucan on 2022/08/18.
//

import UIKit

extension UIViewController {
    func transitionViewController<T: UIViewController>(storyboard sb: String, viewController vc: T) {
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
        self.present(viewController, animated: true)
    }
}
